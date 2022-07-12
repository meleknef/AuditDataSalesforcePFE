public with sharing class ProductTriggerHandler  implements ITrigger{
   
    ProductTriggerHelper hp= new ProductTriggerHelper();
    List<Product2> newItems = (List<Product2>) Trigger.new;
    List<Product2> oldItems = (List<Product2>) Trigger.old;

    List<AuditProduct__c> loggs = new List<AuditProduct__c>();



    public ProductTriggerHandler() {  }

    
    public void bulkBefore() {
        if(trigger.isInsert) {
        //Here we will call before insert actions
        //Here we will call after insert actions
       
        }
    }
        
        
    public void bulkAfter() {
        if(trigger.isInsert) {
            
    
            for (Product2 c : newItems) {
                
                loggs.add(hp.insertProduct(c));}
        
              
              if (Schema.sObjectType.Product2.iscreateable()) {
                insert(loggs);
                hp.sendNotification('Insert', 'inserted');
            
            }
        
        } 
        else if(trigger.isUpdate) {
        //Here we will call after update actions

            Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Product2.fields.getMap();
            for (Product2 gpl : newItems) {
              Product2 oldGPL = (Product2)Trigger.oldMap.get(gpl.Id);
              loggs.add(hp.updateHelper(gpl, oldGPL, mapFields));
            }
            if (Schema.sObjectType.Product2.iscreateable()) { 
                insert(loggs);
                hp.sendNotification('Update','updated');
                
            }

        } else if(trigger.isDelete) {
        //Here we will call after delete actions
        for (Product2 c : oldItems) {
            loggs.add(hp.deleteProduct(c));
          }
          insert(loggs);
          hp.sendNotification('Delete','deleted');
        } else if(trigger.isUndelete) {
        //Here we will call after undelete actions
        }
        }
}