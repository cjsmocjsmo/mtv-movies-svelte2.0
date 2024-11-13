<script>
    import  { onMount } from 'svelte';
    import BackArrow from '$lib/components/BackArrow.svelte'
    import TempChart from '$lib/components/Temp_Chart.svelte';
    import YesterdayChart from '$lib/components/Yesterdays_Temp_Chart.svelte';
    
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

<div>
    <BackArrow path="/"/>
    <h2 class="currentcon">Current Conditions</h2>
    <div class="foo">
		<h3 class="bar">{tempf}°F</h3>
		<h3 class="bar">{tempc}°C</h3>
		<h3 class="bar">{humi}%H</h3>
		<h3 class="bar">{timestamp}</h3>
	</div>
    <div class="bazbar">
        <div class="foobar">
            <h2>Todays Temps</h2>
            <div class="todaysChart">
                <TempChart />
            </div>
        </div>
        <div class="foobar">
            <h2>Yesterdays Temps</h2>
            <div class="todaysChart">
                <YesterdayChart />
            </div>
        </div>
    </div>  
</div>


<style>
    .bazbar{
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
    .foobar {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 1em;
    }
    .foo {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	.bar {
		color: rgb(0, 217, 255);
        margin: 1em;
	}
    .todaysChart {
        width: 600px;
    }
    .currentcon {
        text-align: center;
    }

</style>