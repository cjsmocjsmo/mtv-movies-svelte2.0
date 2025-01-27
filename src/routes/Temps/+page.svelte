<script>
    import  { onMount } from 'svelte';
    import BackArrow from '$lib/components/BackArrow.svelte'
    import TempChart from '$lib/components/Temp_Chart.svelte';
    import TempChartHome from '$lib/components/Temp_Chart_Home.svelte';
    import YesterdayChart from '$lib/components/Yesterdays_Temp_Chart.svelte';
    import YesterdayChartHome from '$lib/components/Yesterdays_Temp_Chart_Home.svelte';
    import NavBar from '$lib/components/NavBar.svelte';
    
    let tempf = "";
	let tempc = "";
    let tempo = "";
	let humi = "";
	let timestamp = "";

    let tempfHome = "";
    let tempcHome = "";
    let humiHome = "";
    let timestampHome = "";



    async function fetchData() {
        const response = await fetch('http://10.0.4.218:8080/tempf');
        const newData = await response.json();
        tempf = newData;

        const response2 = await fetch('http://10.0.4.218:8080/tempc');
        const newData2 = await response2.json();
        tempc = newData2;

        const response22 = await fetch('http://10.0.4.218:8080/tempo');
        const newData22 = await response22.json();
        tempo = newData22;

        const response3 = await fetch('http://10.0.4.218:8080/humi');
        const newData3 = await response3.json();
        humi = newData3;

		const response4 = await fetch('http://10.0.4.218:8080/timestamp');
		const newData4 = await response4.json();
		timestamp = newData4;

        const response5 = await fetch('http://10.0.4.72:8080/tempf');
        const newData5 = await response5.json();
        tempfHome = newData5;

        const response6 = await fetch('http://10.0.4.72:8080/tempc');
        const newData6 = await response6.json();
        tempcHome = newData6;

        const response7 = await fetch('http://10.0.4.72:8080/humi');
        const newData7 = await response7.json();
        humiHome = newData7;

        const response8 = await fetch('http://10.0.4.72:8080/timestamp');
        const newData8 = await response8.json();
        timestampHome = newData8;
	}

    onMount(() => {
        fetchData();
        const interval = setInterval(fetchData, 5 * 60 * 1000); // 15 minutes in milliseconds

        return () => clearInterval(interval); // Cleanup interval on component destroy
    });
</script>

<div>
    <BackArrow path="/"/>

    <NavBar />

    <div>
        <h1>Shed</h1>
        <h2 class="currentcon">Current Conditions</h2>
        <div class="foo">
            <h3 class="bar">{tempf}°F</h3>
            <h3 class="bar">{tempc}°C</h3>
            <h3 class="bar">{tempo}°F</h3>
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
    <div>
        <h1>Home</h1>
        <h2 class="currentcon">Current Conditions</h2>
        <div class="foo">
            <h3 class="bar">{tempfHome}°F</h3>
            <h3 class="bar">{tempcHome}°C</h3>
            <h3 class="bar">{tempo}°F</h3>
            <h3 class="bar">{humiHome}%H</h3>
            <h3 class="bar">{timestampHome}</h3>
        </div>
        <div class="bazbar">
            <div class="foobar">
                <h2>Todays Temps</h2>
                <div class="todaysChart">
                    <TempChartHome />
                </div>
            </div>
            <div class="foobar">
                <h2>Yesterdays Temps</h2>
                <div class="todaysChart">
                    <YesterdayChartHome />
                </div>
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