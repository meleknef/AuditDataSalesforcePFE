public with sharing class OpportunityTriggerHandler implements ITrigger {

    //private List<Opportunity> newItems;
    private Map<Id, Opportunity> oldMap;
    private List<Opportunity> oldItems;
    private Map<Id, Opportunity> newMap;

    private String email;
    private String obj;
    private String body;
    
    OpportunityTriggerHelper  helper = new OpportunityTriggerHelper();
   
    

    public OpportunityTriggerHandler() {
        //this.newItems = (List<Opportunity>) Trigger.new;
        this.oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
 	    this.oldItems= (List<Opportunity>) Trigger.old;
        this.newMap = (Map<Id, Opportunity>) Trigger.newMap;
    }
    
    public void bulkBefore() {
    if(trigger.isInsert) {
    //Here we will call before insert actions
    } 
    }
    
    public static void bulkAfter() {
    if(trigger.isInsert) {

        List<Opportunity> newItems = (List<Opportunity>) Trigger.new;
    
        for (Opportunity opp : newItems) {
            //Set RecordTypeId according cel_source__c
            String email ='imenghouil21@gmail.com';
            String obj= 'Insert of new Opportunity';
            String body= UserInfo.getName() +' has inserted a new Opportunity by the name of ' + opp.Name ;
            OpportunityTriggerHelper.sendMail(email, obj,body);

    }
    
    } else if(trigger.isUpdate) {
    //Here we will call after update actions
    } else if(trigger.isDelete) {
    //Here we will call after delete actions
    } else if(trigger.isUndelete) {
    //Here we will call after undelete actions
    }
    }
    }