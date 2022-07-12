/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-08-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountTriggerHelper {

    List<AuditAccount__c> logs = new List<AuditAccount__c>();

    public  AuditAccount__c insertAccount(SObject objA) {
      AuditAccount__c obj = new AuditAccount__c();
      obj.ObjectId__c = objA.Id;
      obj.ObjectName__c = (String)objA.get('Name');
      String aaa = obj.ObjectName__c;
      System.debug('object name: ');
      System.debug(aaa);
      obj.ChangeDate__c = Date.today();//Datetime.now();
      System.debug('date format'+obj.ChangeDate__c);
      obj.Action__c = 'insert';
      obj.ConcernedObject__c = objA.getsobjecttype().getdescribe().getname();
      obj.Concerned_User__c = UserInfo.getUserId();
      obj.UserName__c = UserInfo.getName();  
      return obj;
    }

    public void sendNotification(String action, String verbe) {
      List <AuditAccount__c>lsss = [SELECT Id, ConcernedObject__c, ChangeDate__c, ObjectName__c from AuditAccount__c 
      ORDER BY ChangeDate__c DESC];
      CustomNotificationType notificationType = 
      [SELECT Id
        FROM CustomNotificationType 
        WHERE DeveloperName='Account_Notify'];
      // Create a new custom notification
      Messaging.CustomNotification notification = new Messaging.CustomNotification();
      // Set the contents for the notification
      notification.setTitle(action);
      notification.setBody(
        UserInfo.getName() +
        ' has '+ verbe + ' '+lsss[0].ObjectName__c+ ' as '+
        lsss[0].ConcernedObject__c
      );
      // Set the notification type and target
      notification.setNotificationTypeId(notificationType.Id);
      notification.setTargetId(lsss[0].Id);
      //notification.setTargetId
      try {
        notification.send(new Set<String>{UserInfo.getUserId()});
      } catch (Exception e) {
        System.debug('Problem sending notification: ' + e.getMessage());
      }
    }

    public AuditAccount__c updateHelper(
      SObject nv,
      SObject old,
      Map<String, Schema.SObjectField> mapFields
    ) {
      AuditAccount__c obj = new AuditAccount__c();
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

    public AuditAccount__c deleteAccount(SObject objA) {
    
      AuditAccount__c obj = new AuditAccount__c();
      deleted_records__x delt = new deleted_records__x();
      obj.ChangeDate__c = Date.today();
      obj.Action__c = 'delete';
      String idObj= (Id) objA.get('Id');
      obj.ObjectId__c = idObj;
      obj.ObjectName__c = (String)objA.get('Name');
      obj.ConcernedObject__c = objA.getsobjecttype().getdescribe().getname();
      obj.Concerned_User__c = UserInfo.getUserId();
      obj.UserName__c = UserInfo.getName();
      obj.Deleted__c = true;
      obj.Backup__c	= false;
      List<AuditAccount__c> lss = [SELECT Id FROM AuditAccount__c WHERE ObjectId__c LIKE :idObj];
      for (AuditAccount__c c : lss){
        c.Deleted__c = true;
        c.Backup__c	= false;
      }
      DataBase.update(lss);

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
      /********************************* */
      /*Blob exampleIv = Blob.valueOf('Example of IV123');
      Blob key = Crypto.generateAesKey(128);
      Blob data = Blob.valueOf('Data to be encrypted');
      Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

      Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
      String decryptedString = decrypted.toString();
      System.assertEquals('Data to be encrypted', decryptedString);*/

      
      Database.insertAsync(delt);
      System.debug('delt: ');
      System.debug(aa);

      return obj;
    }
 
    public AccountTriggerHelper() {}

}