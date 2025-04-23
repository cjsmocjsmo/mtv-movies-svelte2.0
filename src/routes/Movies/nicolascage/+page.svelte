<script>
	import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
	import MovList from '$lib/components/MovList.svelte';

	let ws;
	let data = $state([]);

	function initWebSocket() {
		const wsuri = 'ws://10.0.4.41:8765';
		ws = new WebSocket(wsuri);
		console.log('WebSocket connection created: ' + wsuri);

		ws.onopen = function () {
			console.log('WebSocket connection opened: ' + wsuri);
			ws.send(JSON.stringify({ "command": 'nicolascage' }));
		};

		ws.onmessage = function (event) {
			data = JSON.parse(event.data);
			console.log('Message received from server: ', data);
		};

		ws.onclose = function () {
			console.log('WebSocket connection closed');
		};

		ws.onerror = function (error) {
			console.error('WebSocket error: ', error);
		};
	}

	onMount(() => {
		console.log('Component mounted');
		initWebSocket();
	});

	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
</script>

<main>
	<BackArrow path="/" />
	<h1>Nicolas Cage</h1>
	<MovList {data} />
</main>

<style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
</style>
