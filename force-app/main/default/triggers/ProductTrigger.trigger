trigger ProductTrigger on Product2 (after delete, after insert, after update, before delete, before insert, before update) {
    
    TriggerFactory.createHandler(Product2.sObjectType);

}