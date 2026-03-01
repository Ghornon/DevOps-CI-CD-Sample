import db from './database';

function makeCorsHeaders(origin: string | null) {
	const allowedOrigins = new Set([
		'http://localhost',
		'http://localhost:80',
		'http://localhost:5173',
		'http://127.0.0.1',
		'http://127.0.0.1:80',
		'http://127.0.0.1:5173',
	]);
	const isAllowed = origin !== null && allowedOrigins.has(origin);
	return {
		'Access-Control-Allow-Origin': isAllowed ? origin! : 'null',
		'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
		'Access-Control-Allow-Headers': 'Content-Type, Authorization',
		'Access-Control-Allow-Credentials': 'true',
	};
}

const server = Bun.serve({
	fetch: async (req: Request) => {
		const origin = req.headers.get('origin');
		const corsHeaders = makeCorsHeaders(origin);

		if (req.method === 'OPTIONS') {
			return new Response(null, { status: 204, headers: corsHeaders });
		}

		const url = new URL(req.url);

		if (url.pathname === '/' && req.method === 'GET') {
			return new Response('Hello from Bun!', {
				status: 200,
				headers: corsHeaders,
			});
		}

		if (url.pathname === '/api/db' && req.method === 'GET') {
			console.log('Received request for /api/db');

			try {
				const rows = await db`SELECT NOW() AS time`;

				const body = JSON.stringify({
					time: rows[0].time,
					api: 'Bun',
				});

				return new Response(body, {
					status: 200,
					headers: {
						...corsHeaders,
						'Content-Type': 'application/json',
					},
				});
			} catch (err) {
				console.error('db error:', err);
				return new Response('Internal Server Error', {
					status: 500,
					headers: corsHeaders,
				});
			}
		}

		if (url.pathname === '/api/ping' && req.method === 'POST') {
			return new Response('pong', { status: 200, headers: corsHeaders });
		}

		return new Response('Not Found', { status: 404, headers: corsHeaders });
	},
	port: parseInt(process.env.PORT || '8080'),
});

console.log(`Server running at ${server.url}`);
