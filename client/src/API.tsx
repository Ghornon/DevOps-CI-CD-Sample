const base_url: string = window.location.origin;

export async function fetchAPI(endpoint: string, method = 'GET') {
	const url = new URL(endpoint, base_url);

	const res = await fetch(url, { method });

	if (!res.ok) {
		throw new Error(`API call failed with status ${res.status}`);
	}

	return res;
}
