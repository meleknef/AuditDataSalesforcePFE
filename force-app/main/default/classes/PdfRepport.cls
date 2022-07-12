public with sharing class PdfRepport {
    public List<AuditAccount__c> Records {get; set;}
    public PdfRepport() {
        Records =  [
            SELECT Name, ConcernedObject__c , UserName__c, 
            Action__c, ChangeDate__c
            FROM AuditAccount__c WHERE ChangeDate__c = LAST_MONTH 
                                 ORDER BY ChangeDate__c
            ];
    }

@AuraEnabled
    public static void sendReport() {
 
        string [] toaddress= New string[]{'melek.nefoussi@esprit.tn'};
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(toaddress);
        message.setSubject('Audit des comptes ');
        message.setsaveasactivity(false);
        message.setHtmlBody('L audit de ce mois des comptes');
        
     
        PageReference pdf = Page.ListAuditAccountPdf;
            
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
        attachment.setBody(reportPdf);
        message.setFileAttachments(new Messaging.EmailFileAttachment[]{ attachment });
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ message });
        
    }

    
}


