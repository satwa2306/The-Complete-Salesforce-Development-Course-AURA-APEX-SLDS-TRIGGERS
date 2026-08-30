public with sharing class GameResultController {
    @AuraEnabled
    public static list<Word_Reshuffle__c > resultQueue() {

      String  userID= UserInfo.getUserId();
      list<Word_Reshuffle__c>  results =[SELECT Id,Name,Mode__c,CreatedDate,Result__c
      FROM Word_Reshuffle__c
      WHERE CreatedById =:userID ORDER BY CreatedDate DESC
      ];
        return results; 
    }
}