import pg from 'pg';
import config from './config';

const pool = new pg.Pool(config);

export async function query(text: string, params?: any[]) {
	const client = await pool.connect();
	try {
		const res = await client.query(text, params);
		return res;
	} finally {
		client.release();
	}
}
