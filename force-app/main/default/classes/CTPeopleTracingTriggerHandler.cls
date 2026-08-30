public with sharing class CTPeopleTracingTriggerHandler {
    public static void  BeforeInsert(List<People_Tracing__c> newRecords) {


        List<People_Tracing__c> duplicates= CTPeopleTracingController.checkDuplicates(newRecords);



        for(People_Tracing__c Trace:duplicates){

            Trace.addError('Duplicate record found '+Trace.Person_1__c + 'Duplicate record found person 2'+Trace.Person_2__c);


        }

    }
}
