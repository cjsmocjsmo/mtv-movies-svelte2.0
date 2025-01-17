<script>
    import { onMount } from 'svelte';
    import Chart from 'chart.js/auto';

    async function get_todays_tempf() {
      const response = await fetch('http://10.0.4.204:8080/todays_tempf');
      const tempfData = await response.json();
      tempfData.forEach((temp, index) => {
        tempfData[index] = Number(temp);
      });
      return tempfData;
    }
    
    async function get_todays_humi() {
      const response = await fetch('http://10.0.4.204:8080/todays_humi');
      const humiData = await response.json();
      humiData.forEach((humi, index) => {
        humiData[index] = Number(humi);
      });
      return humiData;
    } 
  
    let chart;

    onMount(async () => {
      const tempf = await get_todays_tempf();
      const humiDATA = await get_todays_humi();

      const ctx = document.getElementById('tempHomeChart').getContext('2d');
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

<div>
  <canvas id="tempHomeChart"></canvas>
</div>


