import { LightningElement, wire, api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
//import getAuditOpportunity from '@salesforce/apex/ListAudit.getAuditOpportunity';
import sendReport from '@salesforce/apex/ListAuditPdf.sendReport';
import getOpp from '@salesforce/apex/ListAudit.getOpp';
import getBackupOpp from '@salesforce/apex/BackupFunctions.getBackupOpp';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import sendmail from '@salesforce/apex/ScheduledMail.sendmail';
import { NavigationMixin } from 'lightning/navigation';
import backupOpp from '@salesforce/apex/BackupFunctions.backupOpp';
//import jsPDF from  '@salesforce/resourceUrl/jsPDF';

const columns = [
    { label: 'Id audit', fieldName: 'ObjectId__c', sortable: true },
    { label: 'Name', fieldName: 'ObjectName__c', sortable: true },
    { label: 'Action', fieldName: 'Action__c', sortable: true },
    { label: 'User', fieldName: 'UserName__c', sortable: true },
    { label: 'Date', fieldName: 'ChangeDate__c', type: 'date' , sortable: true},
    { label: 'Backup', fieldName: 'Backup__c', sortable: true ,initialWidth: 80, type: 'boolean'},
    { label: 'deleted', fieldName: 'Deleted__c', sortable: true,initialWidth: 80, type: 'boolean'},
    { type: 'button',
        typeAttributes: {  
            label: 'View',  
            name: 'view',    
            value: 'view',
            disabled:{fieldName: 'Deleted__c'},  
            disabled:{fieldName: 'Backup__c'},  
    }},
];

const backs = [
    { label: 'Id objet', fieldName: 'ObjectId__c', sortable: true },
    { label: 'Name', fieldName: 'ObjectName__c', sortable: true },
    { label: 'User', fieldName: 'UserName__c', sortable: true },
    { label: 'Date', fieldName: 'ChangeDate__c', type: 'date' , sortable: true},
    { label: 'Backup', fieldName: 'Backup__c', sortable: true ,initialWidth: 80, type: 'boolean'},
    { type: 'button',
        typeAttributes: {  
            label: 'Backup',  
            name: 'Backup',  
            disabled:{fieldName: 'Backup__c'},  
            value: 'backupOpp',  
    }},
];

export default class OpportunityDetails extends NavigationMixin (LightningElement){

    @track value;
    @track error;
    @track data;
    @api sortedDirection = 'desc';
    @api sortedBy = 'ChangeDate__c';
    @api searchKey = '';
    result;
    @track allSelectedRows = [];
    @track page = 1; 
    @track items = []; 
    @track data = []; 
    @track columns; 
    @track startingRecord = 1;
    @track endingRecord = 0; 
    @track pageSize = 5; 
    @track totalRecountCount = 0;
    @track totalPage = 0;
    isPageChanged = false;
    initialLoad = true;
    mapoppNameVsOpp = new Map();

    @api sortedDirectionb = 'desc';
    @api sortedByb = 'ChangeDate__c';
    resultOpp;
    resultt;
    loading;
    
    @track allData;
    @track allAudit;
    @track pageb = 1; 
    @track itemsb = []; 
    @track backs;
    @track startingRecordb = 1;
    @track endingRecordb = 0; 
    @track pageSizeb = 5; 
    @track totalRecountCountb = 0;
    @track totalPageb = 0;
    isPageChangedb = false;

    data = []; 
    record = {};
    rowOffset = 0;
    recordb = {};
    rowOffsetb = 0;
    loading;

    @track wiredOpportunities;
    @track getBackupOpp;
    // eslint-disable-next-line @lwc/lwc/no-async-await
    /*async connectedCallback() {
        this.data = await getAuditOpportunity({ amountOfRecords: 100 });
    }*/
/******************Audit tab***************** */
    handleRowAction(event) {
        //const actionName = event.detail.action.name;
        const row = event.detail.row;
        onsole.log (row);
        console.log("row...",row.ObjectId__c )
        this.record = row;
        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.ObjectId__c,
                objectApiName: 'Opprtunity', // objectApiName is optional
                actionName: 'view'
            }
        });
    }

    @wire(getOpp, {searchKey: '$searchKey', sortBy: '$sortedBy', sortDirection: '$sortedDirection'})
    wiredOpportunities({ error, data }) {
        if (data) {
            this.processRecords(data);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }
    processRecords(data){
        this.items = data;
            this.totalRecountCount = data.length; 
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); 
            
            this.data = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;
    }
    //clicking on previous button this method will be called
    previousHandler() {
        this.isPageChanged = true;
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
    }

    //clicking on next button this method will be called
    nextHandler() {
        this.isPageChanged = true;
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);            
        }
          
    }

    //this method displays records page by page
    displayRecordPerPage(page){

        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        this.data = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }    
    
    sortColumns( event ) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        return refreshApex(this.result);
        
    }
    
    onRowSelection(event){
        if(!this.isPageChanged || this.initialLoad){
            if(this.initialLoad) this.initialLoad = false;
            this.processSelectedRows(event.detail.selectedRows);
        }else{
            this.isPageChanged = false;
            this.initialLoad =true;
        }
        
    }
    processSelectedRows(selectedOpps){
        var newMap = new Map();
        for(var i=0; i<selectedOpps.length;i++){
            if(!this.allSelectedRows.includes(selectedOpps[i])){
                this.allSelectedRows.push(selectedOpps[i]);
            }
            this.mapoppNameVsOpp.set(selectedOpps[i].Name, selectedOpps[i]);
            newMap.set(selectedOpps[i].Name, selectedOpps[i]);
        }
        for(let [key,value] of this.mapoppNameVsOpp.entries()){
            if(newMap.size<=0 || (!newMap.has(key) && this.initialLoad)){
                const index = this.allSelectedRows.indexOf(value);
                if (index > -1) {
                    this.allSelectedRows.splice(index, 1); 
                }
            }
        }
    }
    
    handleKeyChange( event ) {
        this.searchKey = event.target.value;
        var data = [];
        for(var i=0; i<this.items.length;i++){
            if(this.items[i]!= undefined && this.items[i].Name.includes(this.searchKey)){
                data.push(this.items[i]);
            }
        }
        this.processRecords(data);
    }

    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    increaseRowOffset() {
        this.rowOffset += 100;
    }

    ///////////////// pdf rapport ////////////////////////

    openModall() {
        sendmail().then((result) => {
            this.isModalOpenn = true;
        }).catch(error => {});
    }
    sendReportMail() {
        sendReport().then((result) => {
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'Audit envoy?? par mail sous format PDF !',
                variant: 'info',
            });
            this.dispatchEvent(evt);
        }).catch(error => {});
    }
    closeModall() {
        this.isModalOpenn = false;
    }


    backToAudit(){
        console.log("nav");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://mindful-wolf-u62s68-dev-ed.lightning.force.com/lightning/n/Audit'
            },
        });
        console.log("navvvvvvvvvv");
    }

    viewRapport(){
        console.log("download start");
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/ListAuditOpprtunityPdf'
            }
        });

        console.log("downloaaaaded");
    }

     /*****************backup tab*************** */
     connectedCallback() {
        this.loading = true;
        this.stopLoading(500);
      }   

    bbbackup(event) {
        //const actionName = event.detail.action.name;
        const row = event.detail.row;   
        console.log ('row back', row);
        //console.log("row to backup.",row.hkeyaA-VOIR )
        backupOpp({ sObj: row }).then(resultt => {
            console.log('sObj : ',sObj);
            this.loading = true;
            this.stopLoading(800);
          }).then(resultt => {
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'Your object has been recovered',
                variant: 'info',
            });            
            this.dispatchEvent(evt);
        })
          .catch (error => {
              this.error = error;
        });
    }
          

    @wire(getBackupOpp, {searchKey: '$searchKey', sortByb: '$sortedByb', sortDirectionb: '$sortedDirectionb'})
    getBackupOpp(resultt) {

        this.wiredOpprtunityBackup = resultt;
        console.log('resultt : ' , resultt);
        console.log('datattBB : ' , resultt.data);
        if (resultt.data) 
        {
           this.allData =  resultt.data;
           this.itemsb = this.allData ;
           this.totalRecountCountb = this.allData.length; 
           this.totalPageb = Math.ceil(this.totalRecountCountb / this.pageSizeb); 
           console.log('count deleted: ',this.totalRecountCountb );
           
          this.allData = this.itemsb.slice(0,this.pageSizeb); 
           this.endingRecordb = this.pageSizeb;
           this.backs = backs;
           console.log('dataaa : ' , this.wiredOpprtunityBackup);
           //this.totalcountActionsss = this.totalcountActionsss + this.totalRecountCountb;
           console.log('totaaaaaaaaaaale : ' , this.totalcountActionsss);
        }
        else if (resultt.error) {
            this.error = resultt.error;
            this.backs = undefined;
         }
    }
    //clicking on previous button this method will be called
    previousHandlerb() {
        this.isPageChangedb = true;
        if (this.pageb > 1) {
            this.pageb = this.pageb - 1; //decrease page by 1
            this.displayRecordPerPageb(this.pageb);
        }
    }

    //clicking on next button this method will be called
    nextHandlerb() {
        this.isPageChangedb = true;
        if((this.pageb<this.totalPageb) && this.pageb !== this.totalPageb){
            this.pageb = this.pageb + 1; //increase page by 1
            this.displayRecordPerPageb(this.pageb);            
        }
    }

    //this method displays records page by page
    displayRecordPerPageb(pageb){

        this.startingRecord = ((pageb -1) * this.pageSizeb) ;
        this.endingRecordb = (this.pageSizeb * pageb);

        this.endingRecordb = (this.endingRecordb > this.totalRecountCountb) 
                            ? this.totalRecountCountb : this.endingRecordb; 

        this.allData = this.itemsb.slice(this.startingRecord, this.endingRecordb);
        this.startingRecord = this.startingRecord + 1;
    }    
    
    sortColumnsb( event ) {
        this.sortedByb = event.detail.fieldName;
        this.sortedDirectionb = event.detail.sortDirectionb;
        return refreshApex(this.resultt);
        
    }

    /*increaseRowOffsetb() {
        this.rowOffsetb += 100;
    }*/
    /**
   * The stopLoading utility is used to control a consistant state experience for the user - it ensures that
   * we don't have a flickering spinner effect when the state is in flux.
   * @param {timeoutValue} timeoutValue
   */
    stopLoading(timeoutValue) {
        setTimeout(() => {
            refreshApex(this.wiredOpprtunitys);
            refreshApex(this.wiredOpprtunityBackup);
            this.loading = false;
        }, timeoutValue);
      }


}