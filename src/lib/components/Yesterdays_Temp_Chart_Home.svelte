<script>
    import { onMount } from 'svelte';
    import Chart from 'chart.js/auto';

    async function get_yesterdays_tempf() {
      const response = await fetch('http://10.0.4.203:8080/yesterdays_tempf');
      const tempfData = await response.json();
      tempfData.forEach((temp, index) => {
        tempfData[index] = Number(temp);
      });
      return tempfData;
    }
    
    async function get_yesterdays_humi() {
      const response = await fetch('http://10.0.4.203:8080/yesterdays_humi');
      const humiData = await response.json();
      humiData.forEach((humi, index) => {
        humiData[index] = Number(humi);
      });
      return humiData;
    } 
  
    let chart;

    onMount(async () => {
      const tempf = await get_yesterdays_tempf();
      const humiDATA = await get_yesterdays_humi();

      console.log(tempf);
      console.log(humiDATA);

      const ctx = document.getElementById('yesterdayChartHome').getContext('2d');
      chart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: ['0000', '0100', '0200', '0300', '0400', '0500', '0600', '0700', '0800', '0900', '1000', '1100', '1200',
            '1300', '1400', '1500', '1600', '1700', '1800', '1900', '2000', '2100', '2200', '2300'],
          datasets: [{
            label: "Temps",
            data: tempf,
            fill: false,
            borderColor: 'rgb(255, 0, 0)',
            tension: 0.1
          },
          {
            label: "Humidity",
            data: humiDATA,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          },
        ]
        }
      });
    });
  </script>   

<canvas id="yesterdayChartHome"></canvas>

