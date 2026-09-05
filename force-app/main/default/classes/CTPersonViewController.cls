public with sharing class CTPersonViewController {
    @AuraEnabled
    public static void StatusUpdate(String PersonId) {

        Person__c person=new Person__c(Id=PersonId);

        person.Health_Status__c ='Red';

        update person;

    }
}