public with sharing class ContactTriggerHandler implements ITrigger {

    ContactTriggerHelper hp= new ContactTriggerHelper();
    List<Contact> newItems = (List<Contact>) Trigger.new;
    List<Contact> oldItems = (List<Contact>) Trigger.old;

    List<AuditContact__c> loggs = new List<AuditContact__c>();



    public ContactTriggerHandler() {

    }
    public void bulkBefore() {
        if(trigger.isInsert) {
        //Here we will call before insert actions
        //Here we will call after insert actions
       
        }
    }
        
        
    public void bulkAfter() {
        if(trigger.isInsert) {
            
    
            for (Contact c : newItems) {
                
                loggs.add(hp.insertContact(c));
        
              
              if (Schema.sObjectType.Contact.iscreateable()) {
                Database.insert(loggs);
                hp.sendNotification('Insert', 'inserted');
            }
            }
        
        } 
        else if(trigger.isUpdate) {
        //Here we will call after update actions

            Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Contact.fields.getMap();
            for (Contact gpl : newItems) {
              Contact oldGPL = (Contact)Trigger.oldMap.get(gpl.Id);
              loggs.add(hp.updateHelper(gpl, oldGPL, mapFields));
            }
            if (Schema.sObjectType.Contact.iscreateable()) { 
                Database.insert(loggs);
                hp.sendNotification('Modification','modified');
                
            }

        } else if(trigger.isDelete) {
        //Here we will call after delete actions
        for (Contact c : oldItems) {
            loggs.add(hp.deleteContact(c));
          }
          Database.insert(loggs);
          hp.sendNotification('Suppression','supprimé');
        } else if(trigger.isUndelete) {
        //Here we will call after undelete actions
        }
        }
      

	private void insertContact(Contact c){
	} 
}
