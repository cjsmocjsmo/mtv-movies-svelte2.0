<script>
	let { data } = $props();
	import { isPlaying } from "$lib/stores/isPlaying.js";

	function playvideo(vidid) {
		const wsuri = "ws://10.0.4.41:8765";
		const cmd1 = JSON.stringify({ command: "set_video_media", video_id: vidid });
		const cmd2 = JSON.stringify({ command: "play" });
		let ws = new WebSocket(wsuri);
		ws.onopen = function () {
			ws.send(cmd1);
			ws.send(cmd2);
			// Defer store mutation to avoid state_unsafe_mutation
			setTimeout(() => {
				isPlaying.set(true);
			}, 0);
		};
	}

</script>

<div class="vidlist">
	{#each data as vid}
		<div class="vidlist">
			<button 
				onclick={() => playvideo(vid.VidId)}
				onkeypress={() => playvideo(vid.VidId)}
				onkeyup={() => playvideo(vid.VidId)}
				onkeydown={() => playvideo(vid.VidId)} 
				aria-label={`Play movie: ${vid.Name}`} 
			>
				{vid.Name}
			</button>
		</div>
	{/each}
</div>

<style>
	.vidlist {
		display: flex;
		flex-direction: column;
		flex-wrap: wrap;
		justify-content: center;
		align-items: center;
	}
	button {
		background-color: transparent;
		border: none;
	}
</style>