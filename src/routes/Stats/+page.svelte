<script>
    import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';

	let ws = $state();
	let mov_count = $state(0);
    let tv_count = $state(0);
    let mov_size_on_disk = $state(0);
    let tv_size_on_disk = $state(0);

    const wsuri = "ws://10.0.4.41:8765";

	function movCount() {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket mov_count connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			ws.send(JSON.stringify({ "command": "movcount" }));
		};

		ws.onmessage = function(event) {
			mov_count = JSON.parse(event.data);
			console.log("mov_count Message received from server: ", mov_count);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function tvcount() {
		let ws2 = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

        ws2.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws2.send(JSON.stringify({ "command": "tvcount" }));
        };

        ws2.onmessage = function(event) {
            tv_count = JSON.parse(event.data);
            console.log("Message received from server: ", tv_count);
        };

        ws2.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function movSizeOnDisk() {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket movSizeOnDisk connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "movsizeondisk" }));
        };

        ws.onmessage = function(event) {
            mov_size_on_disk = JSON.parse(event.data);
            console.log("Message received from server: ", mov_size_on_disk);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function tvSizeOnDisk() {
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "tvsizeondisk" }));
        };

        ws.onmessage = function(event) {
            tv_size_on_disk = JSON.parse(event.data);
            console.log("Message received from server: ", tv_size_on_disk);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    onMount(async () => {
        console.log("Component mounted");
        await movCount();
        await tvcount();
        await movSizeOnDisk();
        await tvSizeOnDisk();
    });

	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
</script>

<main>
	<BackArrow path="/" />
	<h1>Stats</h1>
    <h3>Movies: {mov_count}</h3>
    <h3>TV Shows: {tv_count}</h3>
    <h3>Movies Size on Disk: {mov_size_on_disk} GB</h3>
    <h3>TV Shows Size on Disk: {tv_size_on_disk} GB</h3>
	

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
