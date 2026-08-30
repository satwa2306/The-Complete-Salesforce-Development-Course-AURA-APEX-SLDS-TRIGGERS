public with sharing class PersonTriggerController {
   

       public static void beforeInsert(list<person__c> newpersonrecords){
       
        //list<person__c> personrecords=[select id,Health_Status__c,Status_Update_Date__c from Person__c];

            for(Person__c person:newpersonrecords){

             
              person.Health_Status__c='Green';
              person.Token__c =CTPersonController.getToken(person.Mobile__c );
            }


     
       }


        public static void beforeUpdate(list<person__c> newpersonrecords,map<id,person__c> oldmapersonrecords){
       
        //list<person__c> personrecords=[select id,Health_Status__c,Status_Update_Date__c from Person__c];

                       for(Person__c person : newpersonrecords){
                        if(person.Health_Status__c != oldmapersonrecords.get(person.id).Health_Status__c){
                        person.Status_Update_Date__c = Date.today();
            }


        }

     
       }

        public static void afterUpdate(list<person__c> newpersonrecords,map<id,person__c> oldmapersonrecords){
       
        //list<person__c> personrecords=[select id,Health_Status__c,Status_Update_Date__c from Person__c];

        set<id> statuschange=new set<id>();
        set<id> Redstatus=new set<id>();              
        for(Person__c person : newpersonrecords){
                        if(person.Health_Status__c != oldmapersonrecords.get(person.id).Health_Status__c){

                        statuschange.add(person.id);
                       
            }
        
                      
                        if(person.Health_Status__c == 'Red' && oldmapersonrecords.get(person.id).Health_Status__c != 'Red'  ){

                         
                       Redstatus.add(person.id);
            }


        }

        set<id> alreadyprocessed =new set<id>();
        alreadyprocessed.addAll(Redstatus);
        
        set<id> yellowstatus=new set<id>();
        set<id> orangestatus=new set<id>();
        List<person__c> personToupdate=new list<person__c>();

        orangestatus.addAll(CTPersonController.coHabitants(Redstatus,alreadyprocessed));

        set<id> primarycontacts=CTPersonController.Primaycontacts(Redstatus,alreadyprocessed);
        orangestatus.addAll(primarycontacts);


        yellowstatus.addAll(CTPersonController.Neighbour(Redstatus,alreadyprocessed));



        yellowstatus.addAll(CTPersonController.SecondaryContacts(orangestatus,alreadyprocessed));
        for(id pid:orangestatus){


          personToupdate.add(new Person__c(id=pid,Health_Status__c='Orange'));


        }
          

          for(id pid:yellowstatus){


          personToupdate.add(new Person__c(id=pid,Health_Status__c='Yellow'));


        }

        if(personToupdate.size()>0){

          update personToupdate;

        }

        
        list<Location_Tracing__c> LocationTace=CTLocationTracingController.getLocationsByPersonIds(statuschange);
  
        if(LocationTace!=null && LocationTace.size()>0){

          set<id> locationids=new set<id>();
          for(Location_Tracing__c trace:LocationTace){

            locationids.add(trace.Location__c);


          }

          CTLocationController.Updateredscore(locationids);

        }



       }





       }




      



    
  
  