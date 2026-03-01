import { SQL } from 'bun';
import config from './config';

const db = new SQL({
	adapter: 'postgres',
	host: config.host,
	port: config.port,
	user: config.user,
	password: config.password,
	database: config.database,
});

export default db;
