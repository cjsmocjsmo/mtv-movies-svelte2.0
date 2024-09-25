<script>
	import MainMovList from '$lib/components/MainMovList.svelte';
</script>

<svelte:head>
	<title>MTV-Movies</title>
	<meta name="description" content="MTV" />
</svelte:head>

<main>
	<h1>MTV Movies</h1>
	<div class="iconDiv">
		<!-- <div class="movicon">
			<a href="/TVShows/tvshows"
				><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
					<path
						d="M64 64V352H576V64H64zM0 0H64 576h64V64 352v64H576 64 0V352 64 0zM128 448H512h32v64H512 128 96V448h32z"
					/>
				</svg></a
			>
		</div> -->
		<!-- <div class="movicon">
			<a href="/admin">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					width="16"
					height="16"
					fill="currentColor"
					class="bi bi-clipboard2-pulse"
					viewBox="0 0 16 16"
				>
					<path
						d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5h3Z"
					/>
					<path
						d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-12Z"
					/>
					<path
						d="M9.979 5.356a.5.5 0 0 0-.968.04L7.92 10.49l-.94-3.135a.5.5 0 0 0-.926-.08L4.69 10H4.5a.5.5 0 0 0 0 1H5a.5.5 0 0 0 .447-.276l.936-1.873 1.138 3.793a.5.5 0 0 0 .968-.04L9.58 7.51l.94 3.135A.5.5 0 0 0 11 11h.5a.5.5 0 0 0 0-1h-.128L9.979 5.356Z"
					/>
				</svg>
			</a>
		</div> -->
	</div>
	<div>
		<!--  -->
		<MainMovList />
	</div>
	<!--  -->
</main>
<style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
	.iconDiv {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		margin-left: 1em;
	}
	h1 {
		color: yellowgreen;
	}
</style>
<!-- <style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
	svg {
		display: block;
		width: 3em;
		height: 4em;
		fill: brown;
	}
	.movicon {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-right: 1em;
	}
	.iconDiv {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		margin-left: 1em;
	}
	h1 {
		color: yellowgreen;
	}
</style> -->
