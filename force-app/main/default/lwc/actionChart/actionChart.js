import { LightningElement, wire } from 'lwc';
import getActions from '@salesforce/apex/AuditActions.getActions';

export default class ActionChart extends LightningElement {
    chartConfiguration;
 
    @wire(getActions)
    getActions({ error, data }) {
        if (error) {
            this.error = error;
            this.chartConfiguration = undefined;
        } else if (data) {
            let ActionsNumber = [];
            let ObjectNames = [];
            

            for (let i=0; i<(data.length/2); i++){

                ObjectNames.push(data[i]);
                ActionsNumber.push(data[i+(data.length/2)]);
            }
 
            this.chartConfiguration = {
                type: 'bar',
                data: {
                        datasets: [{
                                label: 'Total Actions',
                                backgroundColor: "orange",
                                data: ActionsNumber,
                            }
                        ],
                        labels: ObjectNames,
                    },
                            
                options: {},
            };
            console.log('data => ', data);
            this.error = undefined;
        }
    }
}