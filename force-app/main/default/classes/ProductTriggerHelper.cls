public with sharing class ProductTriggerHelper {
   

    public ProductTriggerHelper() {   }
    List<AuditProduct__c> logs = new List<AuditProduct__c>();

    public  AuditProduct__c insertProduct(SObject objHelper) {
        AuditProduct__c obj = new AuditProduct__c();
        obj.ObjectId__c = objHelper.Id;
        obj.ObjectName__c = (String)objHelper.get('Name');
        obj.ChangeDate__c = Date.today();
        obj.Action__c = 'insert';
        obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
        obj.Concerned_User__c = UserInfo.getUserId();
        obj.UserName__c = UserInfo.getName();
        return obj;
      }

      public void sendNotification(String action, String verbe) {
        List <AuditProduct__c>lsss = [SELECT Id, ConcernedObject__c, ChangeDate__c from AuditProduct__c 
        ORDER BY ChangeDate__c DESC];
        CustomNotificationType notificationType = 
        [SELECT Id
         FROM CustomNotificationType 
         WHERE DeveloperName='Product_Notify'];
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

    public AuditProduct__c updateHelper(
     SObject nv,
     SObject old,
     Map<String, Schema.SObjectField> mapFields
     ) {
      AuditProduct__c obj = new AuditProduct__c();
    for (String str : mapFields.keyset()) {
      if (
        nv.get(str) != old.get(str) 
        &&!(String.valueof(str).equals('lastmodifieddate')) &&
        !(String.valueof(str).equals('systemmodstamp'))
      ) {
        obj.Action__c = 'update';
        obj.ObjectId__c = (Id) old.get('Id');
        obj.ObjectName__c = (String)old.get('Name');
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

  public AuditProduct__c deleteProduct(SObject objHelper) {
   
    AuditProduct__c obj = new AuditProduct__c();
    deleted_records__x delt = new deleted_records__x();
    obj.ChangeDate__c = Date.today();
    obj.Action__c = 'delete';
    obj.ObjectName__c = (String)objHelper.get('Name');
    String IdObj= (Id) objHelper.get('Id');
    obj.ObjectId__c = IdObj;
    obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
    obj.Concerned_User__c = UserInfo.getUserId();
    obj.UserName__c = UserInfo.getName();
    obj.Deleted__c = true;
    obj.Backup__c	= false;
    List<AuditProduct__c> lss = [SELECT Id FROM AuditProduct__c WHERE ObjectId__c LIKE :idObj];
    for (AuditProduct__c c : lss){
      c.Deleted__c = true;
      c.Backup__c	= false;
    }
    DataBase.update(lss);

    Blob data = Blob.valueOf(String.valueOf(JSON.serialize(objHelper)));
    Blob cryptoKey = Crypto.generateAesKey(256);
    Blob encryptedData = Crypto.encryptWithManagedIV('AES256', cryptoKey, data);
    String aa =  EncodingUtil.base64Encode(encryptedData);
    delt.deleted_records__c = EncodingUtil.base64Encode(encryptedData);
    delt.id__c = (Id) objHelper.get('Id');
    delt.key__c = EncodingUtil.base64Encode(cryptoKey);
    delt.deleted_date__c = Date.today();
    delt.deleted_user__c = UserInfo.getName();
    delt.object__c = objHelper.getsobjecttype().getdescribe().getname();
    
    Database.insertAsync(delt);
    System.debug('delt: ');
    System.debug(aa);
    return obj;
  }
}