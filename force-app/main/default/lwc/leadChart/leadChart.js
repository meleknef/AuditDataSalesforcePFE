import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import chartjs from '@salesforce/resourceUrl/ChartJS';
import { loadScript } from 'lightning/platformResourceLoader';
import getLeadActions from '@salesforce/apex/AuditActions.getLeadActions';


export default class LeadChart extends LightningElement {
    @track listAA;
  
   chart;
   chartjsInitialized = false;
   config={
   type : 'doughnut',
   data :{
   datasets :[
   {
   data: [
   ],
   backgroundColor:  [
      'rgba(255, 99, 132, 0.2)',
      'rgba(75, 192, 192, 0.2)',
      'rgba(201, 203, 207, 0.2)'
      ],
   borderColor: [
          'rgb(255, 99, 132)',
          'rgb(75, 192, 192)',
          'rgb(201, 203, 207)'
        ],
   borderWidth: 1,
      label:'Dataset 1'
   }
   ],
   labels:[]
   },
   options: {
    responsive : true,
legend : {
    position :'right'
},
animation:{
   animateScale: true,
   animateRotate : true
}
}
   };
   renderedCallback()
   {
      if(this.chartjsInitialized)
     {
      return;
     }
     this.chartjsInitialized = true;
     Promise.all([
      loadScript(this,chartjs)
     ]).then(() =>{
       const ctx = this.template.querySelector('canvas.donut')
       .getContext('2d');
       this.chart = new window.Chart(ctx, this.config);
     })
     .catch(error =>{
       this.dispatchEvent(
       new ShowToastEvent({
       title : 'Error loading ChartJS',
       message : error.message,
       variant : 'error',
      }),
     );
   });
   getLeadActions().then((data,error) => {
    this.listAA=data;

   if(this.listAA)
   {
      for(var key in this.listAA)
       {
          this.updateChart(this.listAA[key],key);
       }
   }
  else if(error)
  {
     this.error = error;
     this.listAA = undefined;
  }

});
   }
   
   updateChart(label,count)
   {
      this.chart.data.labels.push(count);
      this.chart.data.datasets.forEach((dataset) => {
      dataset.data.push(label);
      });
      this.chart.update();
    }
}