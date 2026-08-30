trigger CTPersonTrigger on Person__c (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
    
    
    switch on Trigger.operationType{
        
        when BEFORE_INSERT{
            
            //list<person__c> personrecords=[select id,Health_Status__c,Status_Update_Date__c from Person__c];


            PersonTriggerController.beforeInsert(trigger.new);

            
        }
        
        when BEFORE_UPDATE{

/*
                       for(Person__c person : Trigger.new){
                        if(person.Health_Status__c != Trigger.oldmap.get(person.id).Health_Status__c){
                person.Status_Update_Date__c = Date.today();
            }


        }*/

             PersonTriggerController.beforeUpdate(trigger.new,Trigger.oldmap);



    }

    when AFTER_UPDATE{

PersonTriggerController.afterUpdate(trigger.new,Trigger.oldmap);


    }

}
}