public with sharing class ContractTriggerHandler implements ITrigger {
    ContractTriggerHelper hp= new ContractTriggerHelper();
    List<Contract> newItems = (List<Contract>) Trigger.new;
    List<Contract> oldItems = (List<Contract>) Trigger.old;

    List<AuditContract__c> loggs = new List<AuditContract__c>();



    public ContractTriggerHandler() {}
    public void bulkBefore() {
        if(trigger.isInsert) {
        //Here we will call before insert actions
        }
    }
        
        
    public void bulkAfter() {
        if(trigger.isInsert) {
            //Here we will call after insert actions
    
            for (Contract c : newItems) {
                
                loggs.add(hp.insertContract(c));}
        
              
              if (Schema.sObjectType.Contract.iscreateable()) {
                insert(loggs);
                hp.sendNotification('Insert', 'inserted');
            
            }
        
        } 
        else if(trigger.isUpdate) {
        //Here we will call after update actions

            Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Contract.fields.getMap();
            for (Contract gpl : newItems) {
              Contract oldGPL = (Contract)Trigger.oldMap.get(gpl.Id);
              loggs.add(hp.updateHelper(gpl, oldGPL, mapFields));
            }
            if (Schema.sObjectType.Contract.iscreateable()) { 
                insert(loggs);
                hp.sendNotification('Update','updated');
                
            }

        } else if(trigger.isDelete) {
        //Here we will call after delete actions
        for (Contract c : oldItems) {
            loggs.add(hp.deleteContract(c));
          }
          insert(loggs);
          hp.sendNotification('Delete','deleted');
        } else if(trigger.isUndelete) {
        //Here we will call after undelete actions
        }
        }
      

}