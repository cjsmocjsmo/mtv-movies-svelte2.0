<script>
    import { onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
	import NavBar from '$lib/components/NavBar.svelte';

	let ws = $state();
	let search_phrase = $state([]);
	let result_data = $state([]);

	function movSearch() {
		const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			console.log(search_phrase);
			ws.send(JSON.stringify({ "command": "search", "phrase": search_phrase }));
			search_phrase = "";
		};

		ws.onmessage = function(event) {
			result_data = JSON.parse(event.data);
			console.log("Message received from server: ", result_data);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function handleKeyDown(event) {
        if (event.key === 'Enter') {
            movSearch(search_phrase);
        }
    }

	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
</script>

<main>
	<BackArrow path="/" />

	<NavBar />
	
	<h1>Search</h1>
	<input bind:value={search_phrase}  onkeydown={handleKeyDown} type="text" placeholder="Enter search term" />
	<button class='movSearch' onclick={() => movSearch(search_phrase)} onkeydown={handleKeyDown} >Submit</button>
	{#if result_data.length > 0}
		<div class="movlist">
		{#each result_data as mov}
				<button
					onclick={() => {
						const cmd1 = JSON.stringify({ "command": "set_media", "media_id": mov.MovId });
						const cmd2 = JSON.stringify({ "command": "play" });
						ws.send(cmd1);
						ws.send(cmd2);
					}}
					aria-label={`Play movie: ${mov.Name}`}
				>
					<img src={mov.HttpThumbPath} alt={mov.Name} />
					<p>{mov.Catagory}</p>
				</button>
		{/each}
		</div>
		<div class="navList">
			<a href="http://10.0.4.76:8090"><h3>Movies</h3></a>
			<a href="http://10.0.4.76:8091"><h3>TvShows</h3></a>
			<a href="http://10.0.4.76:9090"><h3>Music</h3></a>
		</div>
	{/if}
	
</main>

<style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
	input {
		width: 50%;
		height: 2em;
		font-size: 1.25em;
		border-radius: 12px;
		margin: 1em;
		background-color: yellowgreen;
		border-color: black;
	}

	.movlist {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: center;
		align-items: center;
	}

	.movSearch {
		width: 10%;
		height: 2em;
		font-size: 1.25em;
		border-radius: 12px;
		border-color: black;
		margin: 1em;
		background-color: blue;
	}

	.navList {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

	a {
		margin: 1em;
	}

	h3 {
		text-decoration: underline;
	}
</style>
