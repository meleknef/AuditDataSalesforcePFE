public with sharing class deleteLineChart {
    public deleteLineChart() { }

    ///////////////Account/////////////////////////
    @AuraEnabled(cacheable=true)
    public static Integer LastWeekAccount() {
         //List<sObject> lastWeekAccount = new List<sObject>();
        Integer lastWeekAccount =  [SELECT COUNT() 
                 FROM AuditAccount__c 
                 WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekAccount  '+ lastWeekAccount );
        return lastWeekAccount;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLWAccount() { 
         //List<sObject> beforeLWAccount = new List<sObject>();
         Integer beforeLWAccount =  [SELECT COUNT() 
                 FROM AuditAccount__c 
                 WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWAcnt  '+ beforeLWAccount );
        return beforeLWAccount;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLWAccount() { 
         //List<sObject> beforeLLWAccount = new List<sObject>();
         Integer beforeLLWAccount =  [SELECT COUNT() 
                 FROM AuditAccount__c 
                 WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWAcnt '+ beforeLLWAccount );
        return beforeLLWAccount;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLLWAccount() { 
         //List<sObject> beforeLLLWAccount = new List<sObject>();
         Integer beforeLLLWAccount =  [SELECT COUNT() 
                 FROM AuditAccount__c 
                 WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWAcnt '+ beforeLLLWAccount );
        return beforeLLLWAccount;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLLLWAccount() { 
         //List<sObject> beforeLLLLWAcnt = new List<sObject>();
         Integer beforeLLLLWAcnt =  [ SELECT COUNT() FROM AuditAccount__c 
                 WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWAcnt '+ beforeLLLLWAcnt );
        return beforeLLLLWAcnt;
     }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getAccountActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWAccount());
        m2.put('Last Week 4', beforeLLLWAccount());
        m2.put('Last Week 3', beforeLLWAccount());
        m2.put('Last Week 2', beforeLWAccount());
        m2.put('Last Week 1', LastWeekAccount());
        System.debug('matrice Account: ' + m2);
        return m2;
    }

 //////////////////////Contact/////////////
    @AuraEnabled(cacheable=true)
    public static Integer LastWeekContact() {
         //List<sObject> lastWeekContact = new List<sObject>();
         Integer lastWeekContact =  [SELECT COUNT() 
                FROM AuditContact__c 
                WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekContact  '+ lastWeekContact );
        return lastWeekContact;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLWContact() {    
         //List<sObject> beforeLWContact = new List<sObject>();
         Integer beforeLWContact =  [SELECT COUNT() 
                FROM AuditContact__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWContact  '+ beforeLWContact );
        return beforeLWContact;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLWContact() { 
         //List<sObject> beforeLLWContact = new List<sObject>();
         Integer beforeLLWContact =  [SELECT COUNT() 
                FROM AuditContact__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWContact '+ beforeLLWContact );
        return beforeLLWContact;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLLWContact() { 
         //List<sObject> beforeLLLWContact = new List<sObject>();
         Integer beforeLLLWContact =  [SELECT COUNT() 
                FROM AuditContact__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWContact '+ beforeLLLWContact );
        return beforeLLLWContact;
    }

    @AuraEnabled(cacheable=true)
    public static Integer beforeLLLLWContact() { 
         //List<sObject> beforeLLLLWContact = new List<sObject>();
         Integer  beforeLLLLWContact =  [SELECT COUNT() 
                FROM AuditContact__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWContact '+ beforeLLLLWContact );
        return beforeLLLLWContact;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getContactActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWContact());
        m2.put('Last Week 4', beforeLLLWContact());
        m2.put('Last Week 3', beforeLLWContact());
        m2.put('Last Week 2', beforeLWContact());
        m2.put('Last Week 1', LastWeekContact());
        System.debug('matrice Contact: ' + m2);
        return m2;
    }

 ////////////////Contract/////////////////
    @AuraEnabled(cacheable=true)
    public static  Integer LastWeekContract() {
         //List<sObject> lastWeekContract = new List<sObject>();
         Integer lastWeekContract =  [SELECT COUNT() 
                FROM AuditContract__c 
                WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekContract  '+ lastWeekContract );
        return lastWeekContract;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLWContract() { 
         //List<sObject> beforeLWContract = new List<sObject>();   
         Integer beforeLWContract =  [SELECT COUNT() 
                FROM AuditContract__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWContract  '+ beforeLWContract );
        return beforeLWContract;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLWContract() { 
         //List<sObject> beforeLLWContract = new List<sObject>();
         Integer beforeLLWContract =  [SELECT COUNT() 
                FROM AuditContract__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWContract '+ beforeLLWContract );
        return beforeLLWContract;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLWContract() { 
         //List<sObject> beforeLLLWContract = new List<sObject>();
         Integer  beforeLLLWContract =  [SELECT COUNT() 
                FROM AuditContract__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWContract '+ beforeLLLWContract );
        return beforeLLLWContract;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLLWContract() { 
         //List<sObject> beforeLLLLWContract = new List<sObject>();
         Integer beforeLLLLWContract =  [SELECT COUNT()
                FROM AuditContract__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWContract '+ beforeLLLLWContract );
        return beforeLLLLWContract;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getContractActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWContract());
        m2.put('Last Week 4', beforeLLLWContract());
        m2.put('Last Week 3', beforeLLWContract());
        m2.put('Last Week 2', beforeLWContract());
        m2.put('Last Week 1', LastWeekContract());
        System.debug('matrice Contract: ' + m2);
        return m2;
    }
/////////////////Lead/////////////////
    @AuraEnabled(cacheable=true)
    public static  Integer LastWeekLead() {
         //List<sObject> lastWeekLead = new List<sObject>();
         Integer lastWeekLead =  [SELECT COUNT() 
                FROM AuditLead__c 
                WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekLead  '+ lastWeekLead );
        return lastWeekLead;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLWLead() { 
         //List<sObject> beforeLWLead = new List<sObject>();
         Integer beforeLWLead =  [SELECT COUNT() 
                FROM AuditLead__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWLead  '+ beforeLWLead );
        return beforeLWLead;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLWLead() { 
         //List<sObject> beforeLLWLead = new List<sObject>();
         Integer beforeLLWLead =  [SELECT COUNT() 
                FROM AuditLead__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWLead '+ beforeLLWLead );
        return beforeLLWLead;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLWLead() { 
         //List<sObject> beforeLLLWLead = new List<sObject>();
         Integer beforeLLLWLead =  [SELECT COUNT() 
                FROM AuditLead__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWLead '+ beforeLLLWLead );
        return beforeLLLWLead;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLLWLead() { 
         //List<sObject> beforeLLLLWLead = new List<sObject>();
         Integer beforeLLLLWLead =  [SELECT COUNT()
                FROM AuditLead__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWLead '+ beforeLLLLWLead );
        return beforeLLLLWLead;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getLeadActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWLead());
        m2.put('Last Week 4', beforeLLLWLead());
        m2.put('Last Week 3', beforeLLWLead());
        m2.put('Last Week 2', beforeLWLead());
        m2.put('Last Week 1', LastWeekLead());
        System.debug('matrice Lead: ' + m2);
        return m2;
    }
/////////////Opportunity///////////////
    @AuraEnabled(cacheable=true)
    public static  Integer LastWeekOpportunity() {
         //List<sObject> lastWeekOpportunity = new List<sObject>();
         Integer lastWeekOpportunity =  [SELECT COUNT() 
                FROM AuditOpportunity__c 
                WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekOpportunity  '+ lastWeekOpportunity );
        return lastWeekOpportunity;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLWOpportunity() {    
         //List<sObject> beforeLWOpportunity = new List<sObject>();
         Integer beforeLWOpportunity =  [SELECT COUNT() 
                FROM AuditOpportunity__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWOpportunity  '+ beforeLWOpportunity );
        return beforeLWOpportunity;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLWOpportunity() { 
         //List<sObject> beforeLLWOpportunity = new List<sObject>();
         Integer beforeLLWOpportunity =  [SELECT COUNT() 
                FROM AuditOpportunity__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWOpportunity '+ beforeLLWOpportunity );
        return beforeLLWOpportunity;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLWOpportunity() { 
         //List<sObject> beforeLLLWOpportunity = new List<sObject>();
         Integer beforeLLLWOpportunity =  [SELECT COUNT() 
                FROM AuditOpportunity__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWOpportunity '+ beforeLLLWOpportunity );
        return beforeLLLWOpportunity;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLLWOpportunity() { 
         //List<sObject> beforeLLLLWOpportunity = new List<sObject>();
         Integer beforeLLLLWOpportunity =  [SELECT COUNT()
                FROM AuditOpportunity__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWOpportunity '+ beforeLLLLWOpportunity );
        return beforeLLLLWOpportunity;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getOpportunityActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWOpportunity());
        m2.put('Last Week 4', beforeLLLWOpportunity());
        m2.put('Last Week 3', beforeLLWOpportunity());
        m2.put('Last Week 2', beforeLWOpportunity());
        m2.put('Last Week 1', LastWeekOpportunity());
        System.debug('matrice Opportunity: ' + m2);
        return m2;
    }
/////////////////Product/////////////////
    @AuraEnabled(cacheable=true)
    public static  Integer LastWeekProduct() {
         //List<sObject> lastWeekProduct = new List<sObject>();
         Integer lastWeekProduct =  [SELECT COUNT() 
                FROM AuditProduct__c 
                WHERE ChangeDate__c = LAST_WEEK] ;
        System.debug('lastWeekProduct  '+ lastWeekProduct );
        return lastWeekProduct;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLWProduct() {
         //List<sObject> beforeLWProduct = new List<sObject>();
         Integer beforeLWProduct =  [SELECT COUNT() 
                FROM AuditProduct__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:2 AND ChangeDate__c != LAST_N_WEEKS:1]  ;
        System.debug('beforeLWProduct  '+ beforeLWProduct );
        return beforeLWProduct;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLWProduct() { 
         //List<sObject> beforeLLWProduct = new List<sObject>();
         Integer beforeLLWProduct =  [SELECT COUNT() 
                FROM AuditProduct__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:3 AND ChangeDate__c != LAST_N_WEEKS:2] ;
        System.debug('beforeLLWProduct '+ beforeLLWProduct );
        return beforeLLWProduct;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLWProduct() { 
         //List<sObject> beforeLLLWProduct = new List<sObject>();
         Integer beforeLLLWProduct =  [SELECT COUNT() 
                FROM AuditProduct__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:4 AND ChangeDate__c != LAST_N_WEEKS:3] ;
        System.debug('beforeLLLWProduct '+ beforeLLLWProduct );
        return beforeLLLWProduct;
    }

    @AuraEnabled(cacheable=true)
    public static  Integer beforeLLLLWProduct() { 
         //List<sObject> beforeLLLLWProduct = new List<sObject>();
         Integer beforeLLLLWProduct =  [SELECT COUNT()
                FROM AuditProduct__c 
                WHERE ChangeDate__c = LAST_N_WEEKS:5 AND ChangeDate__c != LAST_N_WEEKS:4] ;
        System.debug('beforeLLLLWProduct '+ beforeLLLLWProduct );
        return beforeLLLLWProduct;
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getProductActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Last Week 5', beforeLLLLWProduct());
        m2.put('Last Week 4', beforeLLLWProduct());
        m2.put('Last Week 3', beforeLLWProduct());
        m2.put('Last Week 2', beforeLWProduct());
        m2.put('Last Week 1', LastWeekProduct());
        System.debug('matrice Product: ' + m2);
        return m2;
    }
    ////////////////////////////////////////////////////

    @AuraEnabled(cacheable=true)
     public static Map<String, Map<String, Integer>> getStatsForAllActions() {
       Map<String, Map<String, Integer>> m1 = new Map<String, Map<String, Integer>>();
         m1.put('Account', getAccountActionsPerWeek());
         m1.put('Contact', getContactActionsPerWeek());
         m1.put('Contract', getContractActionsPerWeek());
         m1.put('Lead', getLeadActionsPerWeek());
         m1.put('Opportunity', getOpportunityActionsPerWeek());
         m1.put('Product', getProductActionsPerWeek());
         return m1;
     }

    ////////////////////////////////////////////////////
@AuraEnabled(cacheable=true)
    public static Map<String, Integer> getActionsPerWeek() {
        Map<String,Integer> m2 = new Map<String, Integer>();
        m2.put('Account Last Week 5', beforeLLLLWAccount());
        m2.put('Account Last Week 4', beforeLLLWAccount());
        m2.put('Account Last Week 3', beforeLLWAccount());
        m2.put('Account Last Week 2', beforeLWAccount());
        m2.put('Account Last Week 1', LastWeekAccount());
        m2.put('Contact Last Week 5', beforeLLLLWContact());
        m2.put('Contact Last Week 4', beforeLLLWContact());
        m2.put('Contact Last Week 3', beforeLLWContact());
        m2.put('Contact Last Week 2', beforeLWContact());
        m2.put('Contact Last Week 1', LastWeekContact());
        m2.put('Contract Last Week 5', beforeLLLLWContract());
        m2.put('Contract Last Week 4', beforeLLLWContract());
        m2.put('Contract Last Week 3', beforeLLWContract());
        m2.put('Contract Last Week 2', beforeLWContract());
        m2.put('Contract Last Week 1', LastWeekContract());
        m2.put('Lead Last Week 5', beforeLLLLWLead());
        m2.put('Lead Last Week 4', beforeLLLWLead());
        m2.put('Lead Last Week 3', beforeLLWLead());
        m2.put('Lead Last Week 2', beforeLWLead());
        m2.put('Lead Last Week 1', LastWeekLead());
        m2.put('Opportunity Last Week 5', beforeLLLLWOpportunity());
        m2.put('Opportunity Last Week 4', beforeLLLWOpportunity());
        m2.put('Opportunity Last Week 3', beforeLLWOpportunity());
        m2.put('Opportunity Last Week 2', beforeLWOpportunity());
        m2.put('Opportunity Last Week 1', LastWeekOpportunity());
        m2.put('Product Last Week 5', beforeLLLLWProduct());
        m2.put('Product Last Week 4', beforeLLLWProduct());
        m2.put('Product Last Week 3', beforeLLWProduct());
        m2.put('Product Last Week 2', beforeLWProduct());
        m2.put('Product Last Week 1', LastWeekProduct());
        System.debug('matrice Product: ' + m2);
        return m2;
    }
    
}
