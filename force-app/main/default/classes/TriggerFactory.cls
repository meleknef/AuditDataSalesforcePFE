public with sharing class TriggerFactory {
    public static void createHandler(Schema.sObjectType soType) {
    ITrigger handler = getHandler(soType);
    
    if(handler == null) {
    //throw TriggerException('No Trigger Handler registered for Object Type: ' + soType);
    }
    
    // Execute the handler to fulfil the trigger
    execute(handler);
    }
    private static void execute(ITrigger handler) {
    // Before Trigger
    if(Trigger.isBefore) {
    handler.bulkBefore();
    }
    else {
    handler.bulkAfter();
    }
    }
    
    private static ITrigger getHandler(Schema.sObjectType soType) {
    if(soType == Contact.sObjectType) {
    return new ContactTriggerHandler();
    }
    else if(soType == Opportunity.sObjectType) {
        return new OpportunityTriggerHandler();
        }
    else if(soType == Account.sObjectType) {
        return new AccountTriggerHandler();
            }
    else if(soType == Lead.sObjectType) {
        return new LeadTriggerHandler();
            }
    else if(soType == Product2.sObjectType) {
        return new ProductTriggerHandler();
            }
    else if(soType == Contract.sObjectType) {
        return new ContractTriggerHandler();
            }
    
    return null;
    }
    }
    