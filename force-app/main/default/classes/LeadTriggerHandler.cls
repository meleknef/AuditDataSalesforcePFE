public with sharing class LeadTriggerHandler implements ITrigger {

    LeadTriggerHelper hp= new LeadTriggerHelper();
    List<Lead> newItems = (List<Lead>) Trigger.new;
    List<Lead> oldItems = (List<Lead>) Trigger.old;

    List<AuditLead__c> loggs = new List<AuditLead__c>();


    public LeadTriggerHandler() {  }
    public void bulkBefore() {
        if(trigger.isInsert) {
        //Here we will call before insert actions       
        }
    }
        
    public void bulkAfter() {
        if(trigger.isInsert) {
            for (Lead c : newItems) {
                loggs.add(hp.insertLead(c));}
              if (Schema.sObjectType.Lead.iscreateable()) {
                insert(loggs);
                hp.sendNotification('Insert', 'inserted'); 
            }
        } 
        else if(trigger.isUpdate) {
        //Here we will call after update actions
            Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Lead.fields.getMap();
            for (Lead gpl : newItems) {
              Lead oldGPL = (Lead)Trigger.oldMap.get(gpl.Id);
              loggs.add(hp.updateHelper(gpl, oldGPL, mapFields));
            }
            if (Schema.sObjectType.Lead.iscreateable()) { 
                insert(loggs);
                hp.sendNotification('Update','updated');
                
            }

        } else if(trigger.isDelete) {
        //Here we will call after delete actions
        for (Lead c : oldItems) {
            loggs.add(hp.deleteLead(c));
          }
          insert(loggs);
          hp.sendNotification('Delete','deleted');
        } //else if(trigger.isUndelete) {
        //Here we will call after undelete actions
        //}
        }
      

	
}