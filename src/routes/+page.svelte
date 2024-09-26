<script>
	import MainMovList from '$lib/components/MainMovList.svelte';
</script>

<svelte:head>
	<title>MTV-Movies</title>
	<meta name="description" content="MTV" />
</svelte:head>

<main>
	<h1>MTV Movies</h1>	
	<a href="http://10.0.4.54:8091/"><h3>TvShows</h3></a>
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
	h1 {
		color: yellowgreen;
	}
</style>
