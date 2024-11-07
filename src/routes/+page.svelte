<script>
	import MainMovList from '$lib/components/MainMovList.svelte';
	import  { onMount } from 'svelte';
	

	let tempf = "";
	let tempc = "";
	let humi = "";
	onMount(async () => {
    	const response = await fetch('http://10.0.4.60:8080/tempf');
    	const newData = await response.json();
    	tempf = newData;

		const response2 = await fetch('http://10.0.4.60:8080/tempc');
		const newData2 = await response2.json();
		tempc = newData2;

		const response3 = await fetch('http://10.0.4.60:8080/humi');
		const newData3 = await response3.json();
		humi = newData3;
  	});
</script>

<svelte:head>
	<title>MTV-Movies</title>
	<meta name="description" content="MTV" />
</svelte:head>

<main>
	<h1>MTV Movies</h1>	

	<div class="fuck">
		<a href="http://10.0.4.58:8091/"><h3>TvShows</h3></a>
		<a href="http://10.0.4.76:9090/"><h3>Music</h3></a>
		<a href="/Search"><h3>Search</h3></a>
		
	</div>
	<div>
		<h3>{tempf}°F</h3>
		<h3>{tempc}°C</h3>
		<h3>{humi}%H</h3>
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
	h3 {
		margin: 1em;
	}
	h1 {
		color: yellowgreen;
	}
</style>
