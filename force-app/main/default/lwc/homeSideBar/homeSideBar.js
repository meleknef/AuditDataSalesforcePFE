import { LightningElement , wire, api, track} from 'lwc';
import deleteDeletedRecords from '@salesforce/apex/BackupFunctions.deleteDeletedRecords';
import counttotalactions from '@salesforce/apex/AuditActions.counttotalactions';
import getActions from '@salesforce/apex/AuditActions.getActions';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class HomeSideBar extends LightningElement {
    @track loog ='';
    @track totall = 0;
    @track data;
    totall = 0;
   // totall;
    data;
    total;

    /***************delete deleted __x************/
    deleteDeletedX() {
        deleteDeletedRecords().then((result) => {
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'delete backup deleted records haw been deleted from __x  !',
                variant: 'success',
            });
            this.dispatchEvent(evt);
            loogg = console.log('success deleteDeletedRecords');

        }).catch(error => {
            console.log('erreeeeuuuur deleteDeletedRecords', error);
        });
    }
    /*@wire(getActions)
    getActions({ error, data }) {
            if(data) {
                console.log('fl if dataaaa ', data);
                let ActionsNumber = [];
                for (var key in data){
                    console.log("valueeee",data[key]);
                    ActionsNumber.push(data[key]);
                    console.log('ActionsNumber ',ActionsNumber);
                    this.total = ActionsNumber.length; 
                    console.log('dataaaa total ', total);
                    this.totall += total;
                }
                console.log('dataaaa totallll ', totall);
            }
        else if(error)
        {
            this.error = error;
            this.data = undefined;
            console.log('error total', error);
        }
        
    }*/
    @wire(counttotalactions)
    counttotalactions({ error, data }) {
            if(data) {
                console.log('fl if dataaaa ', data);
                
                    this.totall = data; 
                    console.log('dataaaa total ', this.totall);
                //console.log('dataaaa totallll ', totall);
            }
        else if(error)
        {
            this.error = error;
            this.data = undefined;
            console.log('error total', error);
        }
        
    }

}