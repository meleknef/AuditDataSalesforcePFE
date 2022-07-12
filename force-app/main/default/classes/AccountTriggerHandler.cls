/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-17-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountTriggerHandler implements ITrigger{

    AccountTriggerHelper hp= new AccountTriggerHelper();
    List<Account> newItems = (List<Account>) Trigger.new;
    List<Account> oldItems = (List<Account>) Trigger.old;

    List<AuditAccount__c> loggs = new List<AuditAccount__c>();

    public AccountTriggerHandler() { }
    public void bulkBefore() {
        if(trigger.isInsert) {
        //Here we will call before insert actions
        }
    }
               
    public void bulkAfter() {
        if(trigger.isInsert) {
            //Here we will call after insert actions
            for (Account c : newItems) {
                loggs.add(hp.insertAccount(c));
            }
            if (Schema.sObjectType.Account.iscreateable()) {
                insert(loggs);
                hp.sendNotification('Insert', 'inserted');
            }
        } 
        else if(trigger.isUpdate) {
        //Here we will call after update actions
            Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Account.fields.getMap();
            for (Account gpl : newItems) {
              Account oldGPL = (Account)Trigger.oldMap.get(gpl.Id);
              loggs.add(hp.updateHelper(gpl, oldGPL, mapFields));
            }
            if (Schema.sObjectType.Account.iscreateable()) { 
                insert(loggs);
                hp.sendNotification('Update','updated');
            }
        }
        else if(trigger.isDelete) {
        //Here we will call after delete actions
            for (Account c : oldItems) {
                loggs.add(hp.deleteAccount(c));
            }
            insert(loggs);
            hp.sendNotification('Delete','deleted');
            } /*else if(trigger.isUndelete) {
            //Here we will call after undelete actions   }*/
        }

}