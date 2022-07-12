public with sharing class LeadTriggerHelper {
  public LeadTriggerHelper() { }
  
  List<AuditLead__c> logs = new List<AuditLead__c>();

  public  AuditLead__c insertLead(SObject objHelper) {
      AuditLead__c obj = new AuditLead__c();
      obj.ObjectId__c = objHelper.Id;
      obj.ChangeDate__c = Date.today();
      obj.Action__c = 'insert';
      obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
      obj.Concerned_User__c = UserInfo.getUserId();
      obj.UserName__c = UserInfo.getName();
      String last = (String) objHelper.get('LastName');
      string first = (String) objHelper.get('FirstName');
      String nameCont = first+' '+last;
      obj.ObjectName__c = nameCont;
      System.debug('object name last: '+ last);
      System.debug('object name first: '+ first);
      System.debug('object name : '+ nameCont);
      return obj;
    }

    public void sendNotification(String action, String verbe) {
      List <AuditLead__c>lsss = [SELECT Id, ConcernedObject__c, ChangeDate__c, ObjectName__c from AuditLead__c 
                                 ORDER BY ChangeDate__c DESC];
      CustomNotificationType notificationType = 
      [SELECT Id
       FROM CustomNotificationType 
       WHERE DeveloperName='Lead_Notify'];
      // Create a new custom notification
      Messaging.CustomNotification notification = new Messaging.CustomNotification();
      // Set the contents for the notification
      notification.setTitle(action);
      notification.setBody(
        UserInfo.getName() +
        ' has '+verbe + ' '+ lsss[0].ObjectName__c+ ' as '+
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

  public AuditLead__c updateHelper(
   SObject nv,
   SObject old,
   Map<String, Schema.SObjectField> mapFields
   ) {

    AuditLead__c obj = new AuditLead__c();
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
        obj.Name = (String)old.get('Name');
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
  public AuditLead__c deleteLead(SObject objHelper) {
  
    AuditLead__c obj = new AuditLead__c();
    deleted_records__x delt = new deleted_records__x();
    obj.ChangeDate__c = Date.today();
    obj.Action__c = 'delete';
    String IdObj= (Id) objHelper.get('Id');
    String last = (String) objHelper.get('LastName');
    string first = (String) objHelper.get('FirstName');
    String nameCont = last +' '+first;
    obj.ObjectName__c = nameCont;
    obj.ObjectId__c = IdObj;
    obj.ConcernedObject__c = objHelper.getsobjecttype().getdescribe().getname();
    obj.Concerned_User__c = UserInfo.getUserId();
    obj.UserName__c = UserInfo.getName();
    obj.Deleted__c = true;
    obj.Backup__c	= false;
    List<AuditLead__c> lss = [SELECT Id FROM AuditLead__c WHERE ObjectId__c LIKE :idObj];
    for (AuditLead__c c : lss){
      c.Deleted__c = true;
      c.Backup__c	= false;
    }
    DataBase.update(lss);
    // bcp=(public_Lead1__x)objhlp;
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
    return obj;
  }
    
}