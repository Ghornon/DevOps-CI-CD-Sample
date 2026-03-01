import { query } from './database';

const server = Bun.serve({
	routes: {
		'/': new Response('OK'),

		// Per-HTTP method handlers
		'/info': {
			GET: () =>
				query('SELECT NOW() AS now').then(
					(res: { rows: { now: Date }[] }) =>
						Response.json(
							{ time: res.rows[0]?.now, api: 'Bun' },
							{ status: 200 },
						),
				),
		},

		'/ping': {
			POST: () => new Response('pong'),
		},
	},

	fetch(req) {
		return new Response('Not Found', { status: 404 });
	},
	port: parseInt(process.env.PORT || '8080'),
});

console.log(`Server running at ${server.url}`);
