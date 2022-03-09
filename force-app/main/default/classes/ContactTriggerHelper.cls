public with sharing class ContactTriggerHelper {
    public ContactTriggerHelper() {

    }
    List<AuditContact__c> logs = new List<AuditContact__c>();

    public  AuditContact__c insertContact(SObject objHelper) {
        AuditContact__c obj = new AuditContact__c();
        obj.ObjectId__c = objHelper.Id;
        obj.ChangeDate__c = Date.today();
        obj.Action__c = 'insert';
        obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
        obj.Concerned_User__c = UserInfo.getUserId();
        return obj;
      }
      public void sendNotification(String action, String verbe) {
        List <AuditContact__c>lsss = [SELECT Id, ConcernedObject__c, ChangeDate__c from AuditContact__c 
        ORDER BY ChangeDate__c DESC];
        CustomNotificationType notificationType = 
        [SELECT Id
         FROM CustomNotificationType 
         WHERE DeveloperName='Contact_Notify'];
      
    
        // Create a new custom notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
    
        // Set the contents for the notification
        notification.setTitle(action);
        notification.setBody(
          UserInfo.getName() +
          ' has '+verbe +' an ' +
          lsss[0].ConcernedObject__c
        );
    
        // Set the notification type and target
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(lsss[0].Id);
    
        try {
          notification.send(new Set<String>{UserInfo.getUserId()});
        } catch (Exception e) {
          System.debug('Problem sending notification: ' + e.getMessage());
        }
      }
    public AuditContact__c updateHelper(
     SObject nv,
     SObject old,
     Map<String, Schema.SObjectField> mapFields
     ) {

      AuditContact__c obj = new AuditContact__c();
    for (String str : mapFields.keyset()) {
      if (
        nv.get(str) != old.get(str) 
        &&!(String.valueof(str).equals('lastmodifieddate')) &&
        !(String.valueof(str).equals('systemmodstamp'))
      ) {
        obj.Action__c = 'update';
        obj.ObjectId__c = (Id) old.get('Id');
        obj.Name = (String)old.get('Name');
        obj.Concerned_User__c = UserInfo.getUserId();
        obj.ConcernedObject__c = nv.getsobjecttype().getdescribe().getname();
        obj.ConcernedField__c = String.valueof(str);
        obj.OldValue__c = String.valueof(old.get(str));
        obj.NewValue__c = String.valueof(nv.get(str));
        obj.ChangeDate__c = Date.today();
        return obj;
      }
    }
   
    return obj;
 
  }
  public AuditContact__c deleteContact(SObject objHelper) {
   
    AuditContact__c obj = new AuditContact__c();
    obj.ChangeDate__c = Date.today();
    obj.Action__c = 'delete';
    String IdObj= (Id) objHelper.get('Id');
    obj.ObjectId__c = IdObj;
    obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
    obj.Concerned_User__c = UserInfo.getUserId();
    return obj;
  }
    
}
