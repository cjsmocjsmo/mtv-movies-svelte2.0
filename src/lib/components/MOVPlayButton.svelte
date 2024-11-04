<script>
	import { onMount, onDestroy } from 'svelte';
	export const prerender = false;
	let { movid, src, alt } = $props();

	let ws;

	let playmovie = () => {
		// const ad = 'http://10.0.4.41:8080/startmov/';
		// let ad2 = ad + movid;
		// console.log(ad2);
		// const media_path = fetch(ad2);

		
		ws.onopen = function() {
			console.log("connected: " + wsuri);
			ws.send({"command": "set_media", "media_id": movid});
			ws.send({"command": "play"});
		};
		ws.onclose = function() {
			console.log("ws connection closed");
			ws.close();
		};
		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	onMount(() => {
		console.log("Component mounted");
		const wsuri = "ws://10.0.4.41:8765";
		ws = new WebSocket(wsuri);
	});

	onDestroy(() => {
		if (ws) {
			ws.close();
		}
	});
		
</script>

<!-- svelte-ignore a11y_click_events_have_key_events -->
<!-- svelte-ignore a11y_no_noninteractive_element_interactions -->
<img onclick={playmovie} src={src} alt={alt} />

<style>
	img {
		margin: 1em;
		border-radius: 7px;
	}
</style>
