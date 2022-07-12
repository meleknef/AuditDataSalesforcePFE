public with sharing class BackupFunctions implements Schedulable {
    public BackupFunctions() {}
    
    /////////////////////Account//////////////////////

    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupAcc( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       //String query = 'SELECT id__c, name__c, deleted_date__c, deleted_user__c, object__c FROM deleted_records__x';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c,Deleted__c, Backup__c FROM AuditAccount__c WHERE Action__c LIKE \'%' + a + '%\' ';//' and  Backup__c = false and Deleted__c = true';
       System.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }

    @AuraEnabled
    //public static void backup(deleted_records__x sObj) {
    public static void backup(AuditAccount__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditAccount__c> lssList = new List<AuditAccount__c>();
      List<AuditAccount__c> lss = [SELECT Id FROM AuditAccount__c WHERE ObjectId__c LIKE :kkk];
      for (AuditAccount__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);
      //deleteDeletedRecords();
      
    }

    ////////////////// Contact ///////////////////////

    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupCntct( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       //String query = 'SELECT id__c, name__c, deleted_date__c, deleted_user__c, object__c FROM deleted_records__x';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c,Deleted__c, Backup__c FROM AuditContact__c WHERE Action__c LIKE \'%' + a + '%\' ';
       System.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }
    @AuraEnabled
    //public static void backup(deleted_records__x sObj) {
    public static void backupcnt(AuditContact__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditContact__c> lssList = new List<AuditContact__c>();
      List<AuditContact__c> lss = [SELECT Id FROM AuditContact__c WHERE ObjectId__c LIKE :kkk];
      for (AuditContact__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);
    }
    ////////////////// Contract ///////////////////////

    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupCntrt( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c, Deleted__c, Backup__c FROM AuditContract__c WHERE Action__c LIKE \'%' + a + '%\' ';
       System.debug('query--- :  '+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }
    @AuraEnabled
    //public static void backup(deleted_records__x sObj) {
    public static void backupcntr(AuditContract__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditContract__c> lssList = new List<AuditContract__c>();
      List<AuditContract__c> lss = [SELECT Id FROM AuditContract__c WHERE ObjectId__c LIKE :kkk];
      for (AuditContract__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);
    }
    ////////////////// Lead ///////////////////////

    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupLead( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c, Deleted__c, Backup__c FROM AuditLead__c WHERE Action__c LIKE \'%' + a + '%\' ';
       System.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }

    @AuraEnabled
    public static void backupLead(AuditLead__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditLead__c> lssList = new List<AuditLead__c>();
      List<AuditLead__c> lss = [SELECT Id FROM AuditLead__c WHERE ObjectId__c LIKE :kkk];
      for (AuditLead__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);

    }
    ////////////////// Opportunity ///////////////////////

    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupOpp( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       //String query = 'SELECT id__c, name__c, deleted_date__c, deleted_user__c, object__c FROM deleted_records__x';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c,Deleted__c, Backup__c FROM AuditOpportunity__c WHERE Action__c LIKE \'%' + a + '%\' ';
       System.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }

    @AuraEnabled
    //public static void backup(deleted_records__x sObj) {
    public static void backupOpp(AuditOpportunity__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditOpportunity__c> lssList = new List<AuditOpportunity__c>();
      List<AuditOpportunity__c> lss = [SELECT Id FROM AuditOpportunity__c WHERE ObjectId__c LIKE :kkk];
      for (AuditOpportunity__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);
    }
    ////////////////// Product ///////////////////////
    
    @AuraEnabled(cacheable=true)
    public static List<deleted_records__x> getBackupProd( String searchKey, String sortByb, String sortDirectionb) {
      String a = 'Delete';
       //String query = 'SELECT id__c, name__c, deleted_date__c, deleted_user__c, object__c FROM deleted_records__x';
       String query = 'SELECT ObjectId__c, UserName__c, ChangeDate__c, ObjectName__c,Deleted__c, Backup__c FROM AuditProduct__c WHERE Action__c LIKE \'%' + a + '%\'';//' and  Backup__c = false';
       System.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' and ObjectName__c LIKE :key';
           System.debug('query search'+query);
       }
       if ( sortByb != null && sortDirectionb != null ) {
           query += ' ORDER BY ' + sortByb + ' ' + sortDirectionb;
           System.debug('query sort'+query);
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
    }
    @AuraEnabled
    public static void backupProd(AuditProduct__c sObj) {

      deleted_records__x backupRecord = new deleted_records__x();
      List<deleted_records__x> backupRecordd = [
                        SELECT id__c, deleted_records__c, key__c
                        FROM deleted_records__x
                      ];
      for (deleted_records__x aa : backupRecordd) {
        if (aa.id__c == sObj.ObjectId__c)
        {
          System.debug('deleted record id successssss');
          System.debug(aa.id__c );
          backupRecord = aa;
        }
      }
      Blob data = EncodingUtil.base64Decode(backupRecord.deleted_records__c);
      Blob privateKey = EncodingUtil.base64Decode(backupRecord.key__c);
      Blob decryptedData = Crypto.decryptWithManagedIV(
        'AES256',
        privateKey,
        data
      );
      System.debug('dataaaa : '+ data );
      System.debug('data decrepted : '+ decryptedData );
  
      // Decode the decrypted data for subsequent use
      String decryptedDataString = decryptedData.toString();
      System.debug('data decrepted : '+ decryptedDataString);
      sObject objs = (sObject) JSON.deserialize(
        decryptedDataString,
        sObject.class
      );
      String kkk = objs.Id;
      objs.Id = null;
      List<sObject> ls = new List<sObject>();
      ls.add(objs);
      Database.insert(ls);
      System.debug('ls : '+ ls);
      System.debug('objs.Id : '+ kkk);
      //Database.delete(sObj);
      //Database.delete(lst);
      List<AuditProduct__c> lssList = new List<AuditProduct__c>();
      List<AuditProduct__c> lss = [SELECT Id FROM AuditProduct__c WHERE ObjectId__c LIKE :kkk];
      for (AuditProduct__c c : lss){
        c.Deleted__c = false;
        c.Backup__c	= true;
        lssList.add(c);
      }
      Database.update(lssList);
    }
///////////////////////////////

/*public without sharing class CustomNotificationFromApex {

  public static void notifydeletes(/ *String targetPage,* / String obj) {

      // Get the Id for our custom notification type
      CustomNotificationType notificationType = 
          [SELECT Id 
           FROM CustomNotificationType 
           WHERE DeveloperName='Custom_Notification'];
      
      // Create a new custom notification
      Messaging.CustomNotification notification = new Messaging.CustomNotification();

      // Set the contents for the notification
      notification.setTitle('Success Delete');
      notification.setBody('Your externel deleted data has been updated ( '+ obj +' )');

      // Set the notification type and target
      notification.setNotificationTypeId(notificationType.Id);
      //notification.setTargetPageRef(targetPage);
      
      // Actually send the notification
      try {
          notification.send(new Set<String>{UserInfo.getUserId()});
      }
      catch (Exception e) {
          System.debug('Problem sending notification: ' + e.getMessage());
      }
  }
/*/

//////////////////////////////
@Future(callout=true)
    public static void deleteDeletedRecords(){

      List<Id> listId = new List<Id>();
      List<Id> listIdd = new List<Id>();
      List<AuditAccount__c> listAcct =[ SELECT objectId__c FROM AuditAccount__c where  Action__c = 'Delete' and  Backup__c = true];
      List<AuditContact__c> listCont =[ SELECT objectId__c FROM AuditContact__c where  Action__c = 'Delete' and  Backup__c = true];
      List<AuditContract__c> listCntr =[ SELECT objectId__c FROM AuditContract__c where  Action__c = 'Delete' and  Backup__c = true];
      List<AuditLead__c> listLead =[ SELECT objectId__c FROM AuditLead__c where  Action__c = 'Delete' and  Backup__c = true];
      List<AuditOpportunity__c> listOpp =[ SELECT objectId__c FROM AuditOpportunity__c where  Action__c = 'Delete' and  Backup__c = true];
      List<AuditProduct__c> listProd =[ SELECT objectId__c FROM AuditProduct__c where  Action__c = 'Delete' and  Backup__c = true];
      if (listAcct != null)
      {
        for (AuditAccount__c item : listAcct){
          listId.add(item.objectId__c);
        }
        System.debug(' acct to delete acct : ' + listId);
      }
      if (listCont != null)
      {
        for (AuditContact__c item : listCont){
          listId.add(item.objectId__c);
        }
        System.debug(' acct to delete cont: ' + listId);
      }
      if (listCntr != null)
      {
        for (AuditContract__c item : listCntr){
          listIdd.add(item.objectId__c);
        }
        System.debug(' acct to delete contract : ' + listId);
      } if (listLead != null)
      {
        for (AuditLead__c item : listLead){
          listId.add(item.objectId__c);
        }
        System.debug(' acct to delete lead : ' + listId);
      }
      if (listOpp != null)
      {
        for (AuditOpportunity__c item : listOpp){
          listId.add(item.objectId__c);
        }
        System.debug(' acct to delete opp : ' + listId);
        
      }
      if (listProd != null)
      {
        for (AuditProduct__c item : listProd){
          listId.add(item.objectId__c);
        }
        System.debug(' acct to delete prod: ' + listId);
      }
      List<deleted_records__x> recordd = [ SELECT id__c FROM deleted_records__x WHERE id__c in :listId ];
      System.debug(' id acct to delete  : ' + recordd);
      DataBase.deleteAsync(recordd);
      /*else {
        System.debug('errroooooor no liste to delete');
      }*/
      
    }

    public void execute(SchedulableContext sc){
      deleteDeletedRecords();
      //System.schedule('Update Account Type Schedule', '0 0 0 * * ?', new deleteDeletedRecords());

    }
}
