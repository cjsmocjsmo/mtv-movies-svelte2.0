<script>
    import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';
	import NavBar from '$lib/components/NavBar.svelte';

	let ws = $state();
	let gallon_total = $state(0);
    let amount_total = $state(0);

	let propane_new_gallons = $state("");
	let propane_new_amount = $state("");

    const wsuri = "ws://10.0.4.41:8765";

	function gallonsTotal() {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket gallonstotal connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			ws.send(JSON.stringify({ "command": "gallonstotal" }));
		};

		ws.onmessage = function(event) {
			let gallon_total_raw = JSON.parse(event.data);
			gallon_total = gallon_total_raw.toFixed(1);
			console.log("gallonstotal Message received from server: ", gallon_total);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function amountTotal() {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

        ws.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws.send(JSON.stringify({ "command": "amounttotal" }));
        };

        ws.onmessage = function(event) {
            let amount_total_raw = JSON.parse(event.data);
			amount_total = amount_total_raw.toFixed(2);
            console.log("Message received from server: ", amountTotal);
        };

        ws.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

	function insertAmount(propane_new_amount) {
		let ws = new WebSocket(wsuri);
		console.log("insertamount WebSocket connection created: " + wsuri);
		console.log("Propane Amount: ");
		console.log(propane_new_amount);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			console.log(propane_new_amount);
			ws.send(JSON.stringify({ "command": "insertamount", "amount": propane_new_amount }));
		};

		ws.onmessage = function(event) {
			console.log("Message received from server: ", event.data);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function insertGallons(propane_new_gallons) {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws.onopen = function() {
			console.log("insertgallons WebSocket connection opened: " + wsuri);
			ws.send(JSON.stringify({ "command": "insertgallons", "gallons": propane_new_gallons }));
		};

		ws.onmessage = function(event) {
			console.log("Message received from server: ", event.data);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

    onMount(async () => {
        console.log("Component mounted");
        await gallonsTotal();
        await amountTotal();
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

	<h1>Propane</h1>
    <div >
        <h1>Total Used: {gallon_total} gal</h1>
        <h1>Total Cost: ${amount_total}</h1>
    </div>
	<div class="main">
		<form class="movlist">
			<label for="gal">Gallons:</label>
			<input class="movSearch" bind:value={propane_new_gallons} type="text" id="gal" name="gal" min="1" max="100">
			<label for="cost">Cost:</label>
			<input class="movSearch" bind:value={propane_new_amount} type="text" id="cost" name="cost" min="1" max="100">
			<button 
				onclick={() => {
					insertAmount(propane_new_amount);
					insertGallons(propane_new_gallons);
					gallonsTotal();
					amountTotal();
					propane_new_amount = "";
					propane_new_gallons = "";
					
				}}
				type="submit">Submit</button>
		</form>
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
		flex-direction: column;
		flex-wrap: wrap;
		justify-content: center;
		align-items: center;
	}

	.movSearch {
		width: 100%;
		height: 2em;
		font-size: 1.25em;
		border-radius: 12px;
		border-color: black;
		margin: 1em;
		background-color: blue;
	}	
</style>
