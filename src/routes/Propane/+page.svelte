<script>
    import { onMount, onDestroy } from 'svelte';
	import BackArrow from '$lib/components/BackArrow.svelte';

	let ws = $state();
	let gallon_total = $state(0);
    let amount_total = $state(0);

	let propane_new_gallons = $state(0);
	let propane_new_amount = $state(0);

    l
    const wsuri = "ws://10.0.4.41:8765";

	function gallonsTotal() {
		let ws = new WebSocket(wsuri);
		console.log("WebSocket mov_count connection created: " + wsuri);

		ws.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			ws.send(JSON.stringify({ "command": "gallonstotal" }));
		};

		ws.onmessage = function(event) {
			gallons_total = JSON.parse(event.data);
			console.log("mov_count Message received from server: ", gallons_total);
		};

		ws.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function amountTotal() {
		let ws2 = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

        ws2.onopen = function() {
            console.log("WebSocket connection opened: " + wsuri);
            ws2.send(JSON.stringify({ "command": "amounttotal" }));
        };

        ws2.onmessage = function(event) {
            amount_total = JSON.parse(event.data);
            console.log("Message received from server: ", amountTotal);
        };

        ws2.onerror = function(error) {
            console.error("WebSocket error: ", error);
        };
    }

	function insertAmount() {
		let ws3 = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws3.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			ws3.send(JSON.stringify({ "command": "insertamount", "amount": propane_new_amount }));
		};

		ws3.onmessage = function(event) {
			console.log("Message received from server: ", event.data);
		};

		ws3.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function insertGallons() {
		let ws4 = new WebSocket(wsuri);
		console.log("WebSocket connection created: " + wsuri);

		ws4.onopen = function() {
			console.log("WebSocket connection opened: " + wsuri);
			ws4.send(JSON.stringify({ "command": "insertgallons", "gallons": propane_new_gallons }));
		};

		ws4.onmessage = function(event) {
			console.log("Message received from server: ", event.data);
		};

		ws4.onerror = function(error) {
			console.error("WebSocket error: ", error);
		};
	}

	function submitForm(amount, gallons) {
		insertAmount(amount);
		insertGallons(gallons);
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
	<h1>Propane</h1>
    <div >
        <h3>Total Used: {gallon_total} gal</h3>
        <h3>Total Cost: ${amount_total}</h3>
    </div>

    <form class="main">
        <label for="gal">Gallons:</label>
        <input bind={propane_new_gallons} type="number" id="gal" name="gal" min="1" max="100">
        <label for="cost">Cost:</label>
        <input bind={propane_new_amount} type="number" id="cost" name="cost" min="1" max="100">
        <button onclick={() => submitForm(propane_new_amount, propane_new_gallons)} type="submit">Submit</button>
    </form>
    
	

</main>

<style>
	main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}
	

	
</style>
