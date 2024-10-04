<script>
	import MainMovList from '$lib/components/MainMovList.svelte';
</script>

<svelte:head>
	<title>MTV-Movies</title>
	<meta name="description" content="MTV" />
</svelte:head>

<main>
	<h1>MTV Movies</h1>	

	<div class="fuck">
		<a href="http://10.0.4.54:8091/"><h3>TvShows</h3></a>
		<a href="http://10.0.4.39:9090/"><h3>Music</h3></a>
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
