public with sharing class AutoUpdatePersonHealth implements Database.Batchable<SObject> {
    public database.QueryLocator start(database.BatchableContext BC) {

        list<String> healthstatus = new list<String>{'Red','Yellow'};

        return database.getQueryLocator('SELECT id from Person__c WHERE Status_Update_Date__c <LAST_N_DAYS:14 AND Health_Status__c IN :healthstatus');

    }

    public void execute(Database.BatchableContext BC,List<person__c> scope){

        for(person__c ar:scope){

            ar.Health_Status__c='Green';

        }

        update ar;
    }

     public void finish(Database.BatchableContext BC){

        system.debug('finished executing');

     }
}