import { useEffect, useState } from 'react';
import reactLogo from './assets/react.svg';
import viteLogo from '/vite.svg';
import bunLogo from './assets/bun.svg';
import './App.css';
import { fetchAPI } from './API';

function App() {
	const [apiStatus, setApiStatus] = useState('Offline');
	const [apiTime, setApiTime] = useState('');

	useEffect(() => {
		// Check API status on mount
		fetchAPI('/').then((res) => {
			if (res.ok) {
				setApiStatus('Online');
			} else {
				setApiStatus('Offline');
			}
		});

		// Fetch data from API
		fetchAPI('/api/db')
			.then((res) => res.json())
			.then((data) => setApiTime(data.time))
			.catch(() => {
				setApiTime('Can not fetch time');
			});
	}, []);

	const isApiOnline = () => (apiStatus === 'Online' ? 'green' : 'red');
	const isApiTimeAvailable = () =>
		new Date(apiTime).getTime() ? 'green' : 'red';

	return (
		<>
			<div>
				<a href="https://bun.com" target="_blank">
					<img src={bunLogo} className="logo" alt="Bun logo" />
				</a>

				<a href="https://react.dev" target="_blank">
					<img
						src={reactLogo}
						className="logo react"
						alt="React logo"
					/>
				</a>

				<a href="https://vite.dev" target="_blank">
					<img src={viteLogo} className="logo" alt="Vite logo" />
				</a>
			</div>
			<h1>Bun + React + Vite</h1>
			<div className="card">
				<p>
					API Server status:{' '}
					<span style={{ color: isApiOnline() }}>{apiStatus}</span>
				</p>
				<p>
					Database time:{' '}
					<span style={{ color: isApiTimeAvailable() }}>
						{apiTime}
					</span>
				</p>
			</div>
			<p className="read-the-docs">
				Sample react app using Bun as the backend server and React +
				Vite as the frontend
			</p>
		</>
	);
}

export default App;
