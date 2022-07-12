import { LightningElement, api, wire } from 'lwc';
import getActions from '@salesforce/apex/AuditActions.getActions';
import getAccountActionsPerWeek from '@salesforce/apex/deleteLineChart.getAccountActionsPerWeek';
import getContactActionsPerWeek from '@salesforce/apex/deleteLineChart.getContactActionsPerWeek';
import getContractActionsPerWeek from '@salesforce/apex/deleteLineChart.getContractActionsPerWeek';
import getLeadActionsPerWeek from '@salesforce/apex/deleteLineChart.getLeadActionsPerWeek';
import getOpportunityActionsPerWeek from '@salesforce/apex/deleteLineChart.getOpportunityActionsPerWeek';
import getProductActionsPerWeek from '@salesforce/apex/deleteLineChart.getProductActionsPerWeek';


export default class ActionChart extends LightningElement {
    chartConfiguration;
    chartConfigurationn;
    isChartJsInitialized;
    ActionsNumber = [];
    Weeks = [];
    Laccount = [];
    Lcontact = [];
    Lcontract = [];
    Llead = [];
    Lopportunity = [];
    lproduct = [];
 
    @wire(getActions)
    getActions({ error, data }) {
        if (data) {
            console.log("data",data);
            console.log(data.Account.Delete);
            let ActionsNumber = [];
            let ObjectNames = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                ObjectNames.push(key);
                ActionsNumber.push(data[key]);
                console.log(ActionsNumber);
            }
 
            this.chartConfiguration = {
                type: 'bar',   
                data: {
                    labels: ObjectNames, 
                    datasets: [{
                            label: 'Total Actions',
                            data: ActionsNumber,
                            backgroundColor:  [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(201, 203, 207, 0.2)'
                                ],
                            borderColor: [
                                    'rgb(255, 99, 132)',
                                    'rgb(255, 159, 64)',
                                    'rgb(75, 192, 192)',
                                    'rgb(54, 162, 235)',
                                    'rgb(153, 102, 255)',
                                    'rgb(201, 203, 207)'
                                  ],
                            borderWidth: 1
                        },{
                            type: 'line',
                            label: 'Line Dataset',
                            data: this.Laccount,
                            backgroundColor:'rgba(119, 210, 71, 0.2)',                        
                        }
                    ],
                },         
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                },
            };
            console.log("lenna");
            console.log('data => ', data);
            this.error = undefined;
        }else if (error) {
            console.log('erroooorooor',error);
            this.error = error;
            this.chartConfiguration = undefined;
        }
    }
        ///////////////////// /line ///////////////////////       
   @wire(getAccountActionsPerWeek)
   getAccountActionsPerWeek({ error, data }) {
        if (data) {
            console.log("data",data);
            let Weeks = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.Laccount.push(data[key]);
                console.log(this.Laccount);
            }
    
            this.chartConfigurationn = {
                  
                data: {
                    labels: Weeks, 
                    type: 'bar', 
                    datasets: [{
                        label: 'Account',
                        data: this.Laccount,
                        //fill: false,
                        backgroundColor: 'rgb(255, 99, 132)',
                        }/*,{
                        type: 'line',
                        label: 'Contact',
                        data: this.Lcontact,
                        fill: false,
                        backgroundColor: 'rgb(255, 159, 64)'
                        
                        },{
                        type: 'line',
                        label: 'Contract',
                        data: this.Lcontract,
                        fill: false,
                        backgroundColor: 'rgb(75, 192, 192)'
                        
                        },{
                        type: 'line',
                        label: 'Lead',
                        data: this.Llead,
                        fill: false,
                        backgroundColor: 'rgb(54, 162, 235)'
                        
                        },{
                        type: 'line',
                        label: 'Opportunity',
                        data: this.Lopportunity,
                        fill: false,
                        backgroundColor: 'rgb(153, 102, 255)'
                        
                        },{
                        type: 'line',
                        label: 'Product',
                        data: this.lproduct,
                        fill: false,
                        backgroundColor: 'rgb(201, 203, 207)'
                    }*/],
                },         
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                },
            };
            console.log("lenna");
            console.log('data => ', data);
            this.error = undefined;
        }else if (error) {
            console.log('erroooooorrr: ',error);
            this.error = error;
            this.chartConfigurationn = undefined;
        }
    }

    //////////////////////////////////

    @wire(getContactActionsPerWeek)
    getContactActionsPerWeek({ error, data }) {
        if (data) {
            let Weeks = [];
            console.log("data",data);
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.Lcontact.push(data[key]);
                console.log(Weeks);
            }
    
            
            console.log("lenna");
            console.log('data => ', data);
            
            this.error = undefined;
        }else if (error) {
            console.log("erreur");
            console.log(error);
            this.error = error;
            //this.chartConfigurationn = undefined;
        }   
    }
    /////////////////////////////

    @wire(getContractActionsPerWeek)
    getContractActionsPerWeek({ error, data }) {
        if (data) {
            console.log("data",data);
            let Weeks = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.Lcontract.push(data[key]);
                console.log(Weeks);
            }
            console.log("lenna");
            console.log('data => ', data);
            
            this.error = undefined;
        }else if (error) {
            console.log("erreur");
            console.log(error);
            this.error = error;
            //this.chartConfigurationn = undefined;
        }   
    }

////////////////////////////
    @wire(getLeadActionsPerWeek)
    getLeadActionsPerWeek({ error, data }) {
        if (data) {
            console.log("data",data);
            let Weeks = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.Llead.push(data[key]);
                console.log(Weeks);
            }
    
            console.log("lenna");
            console.log('data => ', data);
            
            this.error = undefined;
        }else if (error) {
            console.log("erreur");
            console.log(error);
            this.error = error;
            //this.chartConfigurationn = undefined;
        }   
    }
    ////////////////////////////

    @wire(getOpportunityActionsPerWeek)
    getOpportunityActionsPerWeek({ error, data }) {
        if (data) {
            console.log("data",data);
            let Weeks = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.Lopportunity.push(data[key]);;
                console.log(Weeks);
            }
            console.log("lenna");
            console.log('data => ', data);
            this.error = undefined;
        }else if (error) {
            console.log("erreur");
            console.log(error);
            this.error = error;
           // this.chartConfigurationn = undefined;
        }   
    }
    ///////////////////////

    @wire(getProductActionsPerWeek)
    getProductActionsPerWeek({ error, data }) {
        if (data) {
            console.log("data",data);
            let Weeks = [];
            
            for (var key in data){
                console.log("key", key);
                console.log("value",data[key]);
                Weeks.push(key);
                this.lproduct.push(data[key]);
                console.log(Weeks);
            }
            console.log("lenna");
            console.log('data => ', data);
            this.error = undefined;
        }else if (error) {
            console.log("erreur");
            console.log(error);
            this.error = error;
            //this.chartConfigurationn = undefined;
        }   
    }
     
    
    


    /*

    renderedCallbackkk() {
        console.log('saaaaalut');
        if (this.isChartJsInitialized) {
            console.log(' isChartJsInitialized: ',this.isChartJsInitialized);
            return;
        }
        Promise.all([loadScript(this, chartjs)
        ]).then(() => {
            this.isChartJsInitialized = true;
            const ctx = this.template.querySelector('canvas.linechart').getContext('2d');
            console.log(' ctx: ',ctx);
            this.chart = new window.Chart(ctx, this.config);
            this.chart.canvas.parentNode.style.height = '100%';
            this.chart.canvas.parentNode.style.width = '100%';
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading ChartJS',
                    message: error.message,
                    variant: 'error',
                }),
            );
            console.log(' erroooooor: ',error);
        });
        this.config = {
       
             type: 'line',
            data: {
                labels: [],
                type: 'line',
                defaultFontFamily: 'Montserrat',
                datasets: [{
                    label: "Last Week 5",
                    data: [],
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(255, 99, 132)',
                    borderWidth: 3,
                    pointStyle: 'circle',
                    pointRadius: 5,
                    pointBorderColor: 'transparent',
                    pointBackgroundColor:'rgba(255, 99, 132, 0.2)',
                }, {
                    label: "Last Week 4",
                    data: [],
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(255, 159, 64)',
                    borderWidth: 3,
                    pointStyle: 'circle',
                    pointRadius: 5,
                    pointBorderColor: 'transparent',
                    pointBackgroundColor:  'rgba(255, 159, 64, 0.2)',
                }, {
                    label: "Last Week 3",
                    data: [],
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(75, 192, 192)',
                    borderWidth: 3,
                    pointStyle: 'circle',
                    pointRadius: 5,
                    pointBorderColor: 'transparent',
                    pointBackgroundColor: 'rgba(75, 192, 192, 0.2)',
                }, {
                    label: "Last Week 2",
                    data: [],
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(54, 162, 235)',
                    borderWidth: 3,
                    pointStyle: 'circle',
                    pointRadius: 5,
                    pointBorderColor: 'transparent',
                    pointBackgroundColor: 'rgba(54, 162, 235, 0.2)',
                }, {
                    label: "Last Week 1",
                    data: [],
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(153, 102, 255)',
                    borderWidth: 3,
                    pointStyle: 'circle',
                    pointRadius: 5,
                    pointBorderColor: 'transparent',
                    pointBackgroundColor: 'rgba(153, 102, 255, 0.2)',
                }]
            },
            options: {
                responsive: true,
    
                tooltips: {
                    mode: 'index',
                    titleFontSize: 12,
                    titleFontColor: '#000',
                    bodyFontColor: '#000',
                    backgroundColor: '#fff',
                    titleFontFamily: 'Montserrat',
                    bodyFontFamily: 'Montserrat',
                    cornerRadius: 3,
                    intersect: true,
                },
                legend: {
                    labels: {
                        usePointStyle: true,
                        fontFamily: 'Montserrat',
                    },
                },
                scales: {
                    xAxes: [{
                        display: true,
                        gridLines: {
                            display: false,
                            drawBorder: false
                        },
                        scaleLabel: {
                            display: false,
                            labelString: 'Month'
                        }
                    }],
                     yAxes: [{
                        ticks: {
                            suggestedMin: 0,
                            suggestedMax: 10,
                            stepSize: 2
                        }
                    }]
                },
                title: {
                    display: false,
                    text: 'Normal Legend'
                }
            }
        };
                //this.getOptions();

                getStatsForAllActions().then((data,error) => {
                     if(error)
                    {
                        console.log('errorororor',error);
                        this.error = error;
                        this.listStats = undefined;
                    } else if (data){
                        console.log('data line',data);
                        this.listStats=data;
                        for (var key in this.listStats){
                            this.chart.data.labels.push([key]);
                            if (key == "Account"){
                                console.log(' key account: ',key);
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){ 
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        console.log(' this.chart.data.label week5: ',this.chart.data.datasets[i].label);
                                        console.log(' keyy week5: ',keyy);
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                    console.log(' keyy week4: ',keyy);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    console.log(' keyy week3: ',keyy);
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    console.log(' keyy week2: ',keyy);
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    console.log(' keyy week1: ',keyy);
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        else if (key =="Contact"){
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){  
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        else if (key =="Contract"){
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){  
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        else if (key =="Lead"){
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){  
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        else if (key =="Opportunity"){
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){  
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        else if (key =="Product"){
                            for (var keyy in this.listStats[key]){
                                for(let i = 0; i < this.chart.data.datasets.length; i++){  
                                    if (this.chart.data.datasets[i].label == 'Last Week 5' && keyy == 'Last Week 5'){
                                        this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 4' && keyy == 'Last Week 4'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 3' && keyy == 'Last Week 3'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 2' && keyy == 'Last Week 2'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                                else if (this.chart.data.datasets[i].label == 'Last Week 1' && keyy == 'Last Week 1'){
                                    this.chart.data.datasets[i].data.push(this.listStats[key][keyy]);
                                }
                            }
                            }
                        }
                        }
                        this.chart.update();
                        console.log('bay bay!!');
                }
               
            });

    }*/

}
