public with sharing class CTRecentChangesController {

     @AuraEnabled
    public static List<Person__c> getRecentPersonHealthChanges() {

       return CTPersonController.RecentHealthChanges();

    }

     @AuraEnabled
    public  static List<Location__c> getRecentLocationHealthChanges() {

          return  CTLocationController.getRecentStatusChanges();

    }
     @AuraEnabled
        public static List<Person__c>  searchPeople(string searchterm ) {

           return CTPersonController.searchPeople(searchterm);

    }
     @AuraEnabled
        public static List<Location__c> searchLocations(string searchterm) {

           return CTLocationController.searchLocations(searchterm);

    }
}