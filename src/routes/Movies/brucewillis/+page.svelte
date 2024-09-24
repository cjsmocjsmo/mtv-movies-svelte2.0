<!-- <script>
	import { onMount } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
	import MovList from '$lib/components/MovList.svelte';
	
	let data = [];
	onMount(async () => {
		const addr = 'http://10.0.4.41:8080/brucewillis';
		const res = await fetch(addr);
		data = await res.json();
		data = data;
	});
</script> -->
<script>
	import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
	import MovList from '$lib/components/MovList.svelte';

	let ws;
	let data = [];

	// Function to initialize WebSocket connection
	function initWebSocket() {
		const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			// You can send a message or perform an action when the connection opens
			ws.send(JSON.stringify({ "command": "brucewillis" }));
		};

		ws.onmessage = function(event) {
			// console.log("Message received from server: ", event.data);
			// Handle incoming messages from the server
			data = JSON.parse(event.data);
			console.log("Message received from server: ", data);
		};

		ws.onclose = function() {
			console.log("WebSocket connection closed");
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	// Initialize WebSocket connection when the component is mounted
	onMount(() => {
		console.log("Component mounted");
		initWebSocket();
	});

	// Clean up WebSocket connection when the component is destroyed
	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
</script>
<main>
	<BackArrow path="/" />
	<h1>Bruce Willis</h1>
	
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
