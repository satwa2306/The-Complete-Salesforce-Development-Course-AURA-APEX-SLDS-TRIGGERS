trigger CTLocationTrigger on Location__c (before insert,after insert,before update,after update) {


    switch on Trigger.operationType {
        when  BEFORE_INSERT{


            CTLoactionTriggerHandler.beforeInsert(trigger.new);
            /*
            for(Location__c LocationRecords:trigger.new){

            Location__c.Status__c='Green'; 
            */



         }



                 when  BEFORE_UPDATE{


            CTLoactionTriggerHandler.beforeUpdate(trigger.new,Trigger.oldmap);
 
            


         }

                          when  AFTER_UPDATE{


            CTLoactionTriggerHandler.afterUpdate(trigger.new,Trigger.oldmap);

system.debug(Trigger.operationType);
                            
            


         }



     }
   }






