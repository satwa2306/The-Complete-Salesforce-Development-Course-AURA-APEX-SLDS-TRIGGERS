public with sharing class CTLoactionTriggerHandler {
  public static void beforeInsert(list<Location__c> loactionRec) {
    for (Location__c LocationRecords : loactionRec) {
      LocationRecords.Status__c = 'Green';
    }
  }

  public static void beforeUpdate(list<Location__c> loactionRec, Map<Id, Location__c> oldrecords) {
    for (Location__c LocationRecords : loactionRec) {
      if (LocationRecords.Status__c != oldrecords.get(LocationRecords.id).Status__c) {
        LocationRecords.Status_Update_Date__c = Date.today();
      }
    }
  }


  public static void afterUpdate(list<Location__c> loactionRec, Map<Id, Location__c> oldrecords) {
    set<id> statuschange = new Set<id>();

    for (Location__c LocationRecords : loactionRec) {
      if (LocationRecords.Status__c == 'Red' && oldrecords.get(LocationRecords.id).Status__c != 'Red') {
        statuschange.add(LocationRecords.id);
      }

      system.debug(statuschange);

      List<Location_Tracing__c> locatracing = CTLocationTracingController.getLocationsByLocationIds(statuschange);
      Set<Id> personrecords = new Set<id>();

      for (Location_Tracing__c trace : locatracing) {
        personrecords.add(trace.person__c);
      }
      system.debug(personrecords);

      List<person__c> personToUpdate = new List<person__c>();
      for (Id pid : personrecords) {
        personToUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Yellow'));
      }
      if (personToUpdate.size() > 0) {
        update personToUpdate;
      }
    }
  }
}
