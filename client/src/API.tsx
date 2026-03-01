const APIURL: string =
	import.meta.env.VITE_SERVICE_URL || 'http://localhost:8080';

export async function fetchAPI(endpoint: string, method = 'GET') {
	const url = new URL(endpoint, APIURL);

	const res = await fetch(url, { method });

	if (!res.ok) {
		throw new Error(`API call failed with status ${res.status}`);
	}

	return res;
}
