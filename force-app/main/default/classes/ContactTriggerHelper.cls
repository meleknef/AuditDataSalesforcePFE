public with sharing class ContactTriggerHelper {
    public ContactTriggerHelper() { }

    List<AuditContact__c> logs = new List<AuditContact__c>();

    public  AuditContact__c insertContact(Contact objHelper) {
        AuditContact__c obj = new AuditContact__c();
        obj.ObjectId__c = objHelper.Id;
        obj.ChangeDate__c = Date.today();
        obj.Action__c = 'insert';
        obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
        obj.Concerned_User__c = UserInfo.getUserId();
        obj.UserName__c = UserInfo.getName();
        String last = (String) objHelper.get('LastName');
        string first = (String) objHelper.get('FirstName');
        String nameCont = last +' '+first;
        obj.ObjectName__c = nameCont;
        System.debug('object name last: '+ last);
        System.debug('object name first: '+ first);
        System.debug('object name : '+ nameCont);
        //System.debug('name contact   '+ bb);
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
      Contact nv,
      Contact old,
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
        String last = (String) old.get('LastName');
        string first = (String) old.get('FirstName');
        String nameCont = last +' '+first;
        obj.ObjectName__c = nameCont;
        obj.Concerned_User__c = UserInfo.getUserId();
        obj.UserName__c = UserInfo.getName();
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
 public AuditContact__c deleteContact(SObject objA) {
   
    AuditContact__c obj = new AuditContact__c();
    deleted_records__x delt = new deleted_records__x();
    obj.ChangeDate__c = Date.today();
    obj.Action__c = 'delete';
    String idObj= (Id) objA.get('Id');
    obj.ObjectId__c = idObj;
    String last = (String) objA.get('LastName');
    string first = (String) objA.get('FirstName');
    String nameCont = last +' '+first;
    obj.ObjectName__c = nameCont;
    String aze =obj.ObjectName__c;
    System.debug('aze'+ aze);
    obj.ConcernedObject__c = objA.getsobjecttype().getdescribe().getname();
    obj.Concerned_User__c = UserInfo.getUserId();
    obj.UserName__c = UserInfo.getName();
    obj.Deleted__c = true;
    obj.Backup__c	= false;
    List<AuditContact__c> lss = [SELECT Id FROM AuditContact__c WHERE ObjectId__c LIKE :idObj];
    for (AuditContact__c c : lss){
      c.Deleted__c = true;
      c.Backup__c	= false;
    }
    DataBase.update(lss);
   // bcp=(public_contact1__x)objhlp;
   Blob data = Blob.valueOf(String.valueOf(JSON.serialize(objA)));
   Blob cryptoKey = Crypto.generateAesKey(256);
   Blob encryptedData = Crypto.encryptWithManagedIV('AES256', cryptoKey, data);
   String aa =  EncodingUtil.base64Encode(encryptedData);
   delt.deleted_records__c = EncodingUtil.base64Encode(encryptedData);
   delt.id__c = (Id) objA.get('Id');
   delt.key__c = EncodingUtil.base64Encode(cryptoKey);
   delt.deleted_date__c = Date.today();
   delt.deleted_user__c = UserInfo.getName();
   delt.object__c = objA.getsobjecttype().getdescribe().getname();
    Database.insertAsync(delt);
    return obj;
  }
    
  //public ContactTriggerHelper() {} 
}