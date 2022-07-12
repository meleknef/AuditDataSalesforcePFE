/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-08-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ListAuditPdf implements Schedulable {

    public List<AuditAccount__c> Records {get; set;}
    public List<AuditContact__c> contacts {get; set;}
    public List<AuditContract__c> contracts {get; set;}
    public List<AuditLead__c> leads {get; set;}
    public List<AuditOpportunity__c> opportunities {get; set;}
    public List<AuditProduct__c> products {get; set;}

    public ListAuditPdf() {
        Records =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                 FROM AuditAccount__c WHERE ChangeDate__c = THIS_WEEK 
                 ORDER BY ChangeDate__c
        ];
        contacts =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                    FROM AuditContact__c WHERE ChangeDate__c = THIS_WEEK
                    ORDER BY ChangeDate__c
        ];
        contracts =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                    FROM AuditContract__c WHERE ChangeDate__c = THIS_WEEK
                    ORDER BY ChangeDate__c
        ];
        leads =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                    FROM AuditLead__c WHERE ChangeDate__c = THIS_WEEK
                    ORDER BY ChangeDate__c
        ];
        opportunities =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                    FROM AuditOpportunity__c WHERE ChangeDate__c = THIS_WEEK
                    ORDER BY ChangeDate__c
        ];
        products =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
                Action__c, ChangeDate__c
                    FROM AuditProduct__c WHERE ChangeDate__c = THIS_WEEK
                    ORDER BY ChangeDate__c
        ];
                                                
    }

    @Future(callout=true)
    @AuraEnabled
    public static void sendReport() {
 
        string [] toaddress= New string[]{'melek.nefoussi@esprit.tn'};
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(toaddress);
        message.setSubject('Audit de la semaine ');
        message.setsaveasactivity(false);

        message.setHtmlBody('Votre audit de la semaine des donées Salesforce');
        
        
        PageReference pdf = Page.ListAuditPdf;
            
        Blob reportPdf;
        try {
            reportPdf = pdf.getContentAsPDF();
        }
        catch (Exception e) {
            reportPdf = Blob.valueOf(e.getMessage());
        }
        
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setContentType('application/pdf');
        attachment.setFileName('Audit : '+system.today().format());
        attachment.setInline(false);
        //attachment.setBody('reportPdf');
        attachment.body = pdf.getContent();
        message.setFileAttachments(new Messaging.EmailFileAttachment[]{ attachment });
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ message });
 
    }


    public void execute(SchedulableContext sc){
        ListAuditPdf.sendReport();
    }

}