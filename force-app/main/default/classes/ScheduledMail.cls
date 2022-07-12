public with sharing class ScheduledMail {
    public ScheduledMail() { }
    @AuraEnabled
    public static void sendmail()
    {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        //Integer len = 6 ;
        String randStr = '';
        while (randStr.length() < 6) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        /*VerificationCode__c c = new VerificationCode__c ();
        c.generationDate__c = Datetime.now();
        c.code__c = randStr;
        insert(c);*/
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        string [] toaddress= New string[]{'melek.nefoussi@esprit.tn'};
        email.setSubject('Verification Code');
        email.setPlainTextBody(randStr);
        email.setToAddresses(toaddress);
        email.setsaveasactivity(false);
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
    }
}
