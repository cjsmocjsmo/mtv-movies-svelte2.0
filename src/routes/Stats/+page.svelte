<script>
    import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
    import NavBar from '$lib/components/NavBar.svelte';

	let ws = $state();
	let mov_count = $state(0);
    let tv_count = $state(0);
    let mov_size_on_disk = $state(0);
    let tv_size_on_disk = $state(0);
    let mov_updates = $state(false);
    let tv_updates = $state(false);

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

    function checkForMovUpdates() {
        let ws = new WebSocket(wsuri);
        console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "checkformovupdates" }));
        };

        ws.onmessage = function(event) {
            mov_updates = JSON.parse(event.data);
            console.log("Message received from server: ", mov_updates);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function checkForTvUpdates() {
        let ws = new WebSocket(wsuri);
        console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "checkfortvupdates" }));
        };

        ws.onmessage = function(event) {
            tv_updates = JSON.parse(event.data);
            console.log("Message received from server: ", tv_updates);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function update_mov() {
        let ws = new WebSocket(wsuri);
        console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "updatemovs" }));
        };

        ws.onmessage = function(event) {
            mov_updates = JSON.parse(event.data);
            console.log("Message received from server: ", mov_updates);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

    function update_tv() {
        let ws = new WebSocket(wsuri);
        console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "updatetvs" }));
        };

        ws.onmessage = function(event) {
            tv_updates = JSON.parse(event.data);
            console.log("Message received from server: ", tv_updates);
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
        await checkForMovUpdates();
        await checkForTvUpdates();
    });

	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
</script>

<main>
	<BackArrow path="/" />

    <NavBar />
    
	<h1>Stats</h1>
    <h3>Movies: {mov_count}</h3>
    <h3>TV Shows: {tv_count}</h3>
    <h3>Movies Size on Disk: {mov_size_on_disk} GB</h3>
    <h3>TV Shows Size on Disk: {tv_size_on_disk} GB</h3>
	
    <div class="update-div">
        {#if mov_updates.length == 0}
            <p>No movie updates available.</p>
        {:else}
            <button class="update-movs-btn" onclick={update_mov}>Update Movies</button>
            {#each mov_updates as mupdate}
                <p>{mupdate}</p>
            {/each}
        {/if}
        
        {#if tv_updates.length == 0}
            <p>No TV updates available.</p>
        {:else}
            <button class="update-tvs-btn" onclick={update_tv}>Update TV Shows</button>
            {#each tv_updates as tvupdate}
                <p>{tvupdate}</p>
            {/each}
        {/if}
    </div>

</main>

<style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

    .update-div {
        margin-top: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

    }

    .update-movs-btn, .update-tvs-btn {
        padding: 10px 20px;
        margin-bottom: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 12px;
        cursor: pointer;
    }
</style>
