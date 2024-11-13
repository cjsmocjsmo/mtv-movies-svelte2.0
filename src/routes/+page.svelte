<script>
	import MainMovList from '$lib/components/MainMovList.svelte';
	import  { onMount } from 'svelte';

	let tempf = "";
	let tempc = "";
	let humi = "";
	let timestamp = "";

	

	async function fetchData() {
        const response = await fetch('http://10.0.4.60:8080/tempf');
        const newData = await response.json();
        tempf = newData;

        const response2 = await fetch('http://10.0.4.60:8080/tempc');
        const newData2 = await response2.json();
        tempc = newData2;

        const response3 = await fetch('http://10.0.4.60:8080/humi');
        const newData3 = await response3.json();
        humi = newData3;

		const response4 = await fetch('http://10.0.4.60:8080/timestamp');
		const newData4 = await response4.json();
		timestamp = newData4;
	}

		

    onMount(() => {
        fetchData();
        const interval = setInterval(fetchData, 5 * 60 * 1000); // 15 minutes in milliseconds

        return () => clearInterval(interval); // Cleanup interval on component destroy
    });
</script>

<svelte:head>
	<title>MTV-Movies</title>
	<meta name="description" content="MTV" />
</svelte:head>

<main>
	<div class="foo">
		<h3 class="bar">{tempf}°F</h3>
		<h3 class="bar">{tempc}°C</h3>
		<h3 class="bar">{humi}%H</h3>
		<h3 class="bar">{timestamp}</h3>
	</div>
	
	<h1>MTV Movies</h1>	
	<div class="fuck">
		<a href="http://10.0.4.58:8091/"><h3>TvShows</h3></a>
		<a href="http://10.0.4.76:9090/"><h3>Music</h3></a>
		<a href="/Search"><h3>Search</h3></a>
		<a href="/Temps"><h3>Temps</h3></a>
	</div>
	
	<div>
		<MainMovList />
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
	.fuck {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
	.foo {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	.bar {
		color: blue;
	}
	h3 {
		margin: 1em;
	}
	h1 {
		color: yellowgreen;
	}
</style>
