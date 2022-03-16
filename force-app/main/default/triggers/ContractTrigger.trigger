trigger ContractTrigger on Contract (after delete, after insert, after update, before delete, before insert, before update) {
    
    TriggerFactory.createHandler(Contract.sObjectType);

}