/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-08-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ListAudit {
    public ListAudit() { }

    /*@AuraEnabled(cacheable=true)
    public static List<AuditAccount__c> getAuditAccount() {
        return  [SELECT Name, Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c, ObjectName__c
                 FROM AuditAccount__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit account');
     }

    @AuraEnabled(cacheable=true)
    public static Integer getCountAcct() {
        return  [SELECT COUNT()
                 FROM AuditAccount__c ] ;
        //system.debug('liste audit account');
     }

     @AuraEnabled(cacheable=true)
     public static List<AuditContact__c> getAuditContact() {
        return  [SELECT Name, Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c//, ObjectName__c
                 FROM AuditContact__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit contact');
     }
     
     @AuraEnabled(cacheable=true)
     public static List<AuditContract__c> getAuditContract() {
        return  [SELECT Name , Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c//, ObjectName__c
                 FROM AuditContract__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit contract');
     }
     
     @AuraEnabled(cacheable=true)
     public static List<AuditLead__c> getAuditLead() {
        return  [SELECT Name, Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c//, ObjectName__c
                 FROM AuditLead__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit lead');
     }
     
     @AuraEnabled(cacheable=true)
     public static List<AuditOpportunity__c> getAuditOpportunity() {
        return  [SELECT Name, Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c//, ObjectName__c
                 FROM AuditOpportunity__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit opport');
     }

     @AuraEnabled(cacheable=true)
     public static List<AuditProduct__c> getAuditProduct() {
        return  [SELECT Name, Concerned_User__r.Name, Action__c, 
                 ConcernedObject__c, ChangeDate__c, ObjectId__c//, ObjectName__c
                 FROM AuditProduct__c ORDER by ChangeDate__c] ;
        //system.debug('liste audit product');
     }*/

     @AuraEnabled(cacheable=true)
      public static List<AuditAccount__c> getAcct( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update';
        String query = 'SELECT Name, ObjectId__c, UserName__c, Action__c, ChangeDate__c, ObjectName__c, Deleted__c, Backup__c FROM AuditAccount__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
        //'                                                                                                                                         AuditAccount__c WHERE Action__c LIKE \'%' + a + '%\' and Backup__c = false and Deleted__c = true';
       System.debug('query---'+query);
        if ( searchKey != null && searchKey != '' ) {
            String key = '%' + searchKey + '%';
            query += ' AND ObjectName__c LIKE :key';
            System.debug('query search'+query);
        }
        if ( sortBy != null && sortDirection != null ) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        query = query + ' LIMIT 500';
        return Database.query( query );
   }

   @AuraEnabled(cacheable=true)
      public static List<AuditProduct__c> getProd( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update';      
       String query = 'SELECT Name, UserName__c, Action__c, ConcernedObject__c, ChangeDate__c, ObjectId__c, ConcernedField__c, NewValue__c, Deleted__c, Backup__c, ObjectName__c FROM AuditProduct__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
       system.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' AND ObjectName__c LIKE :key';
       }
       if ( sortBy != null && sortDirection != null ) {
           query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
   }

   @AuraEnabled(cacheable=true)
      public static List<AuditLead__c> getLead( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update'; 
        String query = 'SELECT ObjectName__c, UserName__c, Action__c, ChangeDate__c, ObjectId__c, ConcernedField__c, NewValue__c, Deleted__c, Backup__c, Name FROM AuditLead__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
        system.debug('query lead : '+query);
       if ( searchKey != null && searchKey != '' ) {
            String key = '%' + searchKey + '%';
            System.debug('Key'+ key);
            query += ' AND ObjectName__c LIKE :key';
            System.debug('query sort: '+ query);
        }
        if ( sortBy != null && sortDirection != null ) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        query = query + ' LIMIT 500';
        system.debug('query lekhra : '+ query);
        return Database.query( query );
   }

   @AuraEnabled(cacheable=true)
      public static List<AuditContact__c> getConta( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update'; 
       String query = 'SELECT  Name, UserName__c, Action__c, ConcernedObject__c, ChangeDate__c, ObjectId__c, ObjectName__c, ConcernedField__c, NewValue__c, Deleted__c, Backup__c FROM AuditContact__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
       //String query = 'SELECT ObjectId__c, ConcernedObject__c , UserName__c, Action__c, ChangeDate__c, ObjectName__c, Deleted__c, Backup__c FROM AuditAccount__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
       system.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           System.debug('Key'+ key);
           query += ' AND ObjectName__c LIKE :key';
           System.debug('query---'+ query);
       }
       if ( sortBy != null && sortDirection != null ) {
           query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
   }

   @AuraEnabled(cacheable=true)
      public static List<AuditContract__c> getCntra( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update'; 
       String query = 'SELECT ObjectName__c, Name, UserName__c, Action__c, ChangeDate__c, ObjectId__c, ConcernedField__c, NewValue__c, Deleted__c, Backup__c FROM AuditContract__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
       system.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' AND ObjectName__c LIKE :key';
       }
       if ( sortBy != null && sortDirection != null ) {
           query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
   }

   @AuraEnabled(cacheable=true)
      public static List<AuditOpportunity__c> getOpp( String searchKey, String sortBy, String sortDirection) {
        String a = 'Insert';
        String b = 'Update'; 
       String query = 'SELECT  Name, UserName__c, Action__c, ConcernedObject__c, ChangeDate__c, ObjectId__c, ObjectName__c,ConcernedField__c, NewValue__c, Deleted__c, Backup__c FROM AuditOpportunity__c WHERE (Action__c LIKE \'%' + a + '%\' OR Action__c LIKE \'%' + b + '%\')';
       system.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' AND ObjectName__c LIKE :key';
       }
       if ( sortBy != null && sortDirection != null ) {
           query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
       }
       query = query + ' LIMIT 500';
       return Database.query( query );
   }
}