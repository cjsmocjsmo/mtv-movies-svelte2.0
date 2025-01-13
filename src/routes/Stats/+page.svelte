<script>
    import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';

	let ws = $state();
	let mov_count = $state(0);
    let tv_count = $state(0);
    let mov_size_on_disk = $state(0);
    let tv_size_on_disk = $state(0);

	function movCount() {
		const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			console.log(search_phrase);
			ws.send(JSON.stringify({ "command": "movcount" }));
			search_phrase = "";
		};

		ws.onmessage = function(event) {
			result_data = JSON.parse(event.data);
			console.log("Message received from server: ", mov_count);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function tvcount() {
        const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "tvcount" }));
        };

        ws.onmessage = function(event) {
            tv_count = JSON.parse(event.data);
            console.log("Message received from server: ", tv_count);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function movSizeOnDisk() {
        const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

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
        const wsuri = "ws://10.0.4.41:8765";
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
    <h2>Movies: {mov_count}</h2>
    <h2>TV Shows: {tv_count}</h2>
    <h2>Movies Size on Disk: {mov_size_on_disk}</h2>
    <h2>TV Shows Size on Disk: {tv_size_on_disk}</h2>
	

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
