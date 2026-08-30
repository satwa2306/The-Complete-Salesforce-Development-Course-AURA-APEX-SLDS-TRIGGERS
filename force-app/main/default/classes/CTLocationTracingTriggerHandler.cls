public with sharing class CTLocationTracingTriggerHandler {
    public static void beforeInsert(list<Location_Tracing__c> newRecords) {

        List <Location_Tracing__c> duplicates=CTLocationTracingController.checkDuplicates(newRecords);


        for(Location_Tracing__c traces:duplicates){


            traces.addError('dupicate record location id ' + traces.Location__c +' dupicate record person id '+ traces.Person__c);


        }



    }
}