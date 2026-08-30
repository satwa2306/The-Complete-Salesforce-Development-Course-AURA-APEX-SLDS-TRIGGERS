public with sharing class CTPersonController {
    public static String getToken(String mobilenumber) {
             Blob targetBlob = Blob.valueOf(mobilenumber);
            Blob hash = Crypto.generateDigest('MD5', targetBlob);
            String result = EncodingUtil.base64Encode(hash);
            System.debug('Value: ' + result);
           
            
 
            return  result;
    }
             
    public static List<Person__c> RecentHealthChanges() {


          list<Person__c> personList = [SELECT id,Health_Status__c,Mobile__c,Name,Status_Update_Date__c,Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];


            return personList;
    }
        
             public static List<Person__c> searchPeople(string searchterm) {
                 
              searchterm=searchterm+'%';

            return  [SELECT id,Health_Status__c,Mobile__c,Name,Status_Update_Date__c,Token__c FROM Person__c WHERE Name LIKE :searchterm or Mobile__c LIKE :searchterm or Token__c LIKE :searchterm  ORDER BY Status_Update_Date__c DESC NULLS LAST];
        
             }
             public static Person__c getPersonId(string personid) {
                 
                 
                 
                 List<Person__c> people=[SELECT id,Health_Status__c,Mobile__c,Name,Status_Update_Date__c,Token__c FROM Person__c WHERE Id =:personid];
                 
                 if(people != null && people.size()>0){
                     
                     return people[0];
                     
                 }
                 
                 return null;




                 
             

            //return  [SELECT id,Health_Status__c,Mobile__c,Name,Status_Update_Date__c,Token__c FROM Person__c WHERE Id =:personid];

                
               

            }

     

                 public static map<string, integer> getHealthStatusCount(){

                   map<string,integer> existingpeoplemap=new map<string,integer>();
                 
                 
                  
                  for(AggregateResult ar:[SELECT count(id) total,Health_Status__c 
                                                    FROM Person__c 
                                                    GROUP BY Health_Status__c] ){

                   integer healthstatus =Integer.valueof(ar.get('Health_Status__c'));
                   string countids =string.valueof(ar.get('total'));
                    existingpeoplemap.put( countids,healthstatus );

                    

                  }

                 return existingpeoplemap;
                   
                    
                 }

                   public static set<Id> coHabitants(set<id> personIds,set<id> alreadyprocessed){

                   List<String> Healthstatus=new List<String>{'Green','Yellow'};

                   list<People_Tracing__c> personytracingrecords=[SELECT Id,Person_1__c,Person_2__c FROM People_Tracing__c 
                                                                where (Person_1__c IN:personIds OR Person_2__c IN:personIds) 
                                                                AND Contact_Type__c ='Cohabitant' AND 
                                                                (Person_1__r.Health_Status__c IN:Healthstatus OR 
                                                                Person_2__r.Health_Status__c IN:Healthstatus) ];
                    set<id> cohabitants=new set<id>();
                    for(People_Tracing__c pt:personytracingrecords){
                      if(!alreadyProcessed.contains(pt.Person_1__c)){

                        cohabitants.add(pt.Person_1__c);

                        alreadyprocessed.add(pt.Person_1__c);

                      }
                        if(!personIds.contains(pt.Person_2__c)){

                        cohabitants.add(pt.Person_2__c);
                        alreadyprocessed.add(pt.Person_2__c);


                      }

                    }
                    return cohabitants;
                  }


                    public static set<id> Neighbour(set<id> personIds,set<id> alreadyprocessed){

                   //List<String> Healthstatus=new List<String>{'Green','Yellow'};

                   list<People_Tracing__c> personytracingrecords=[SELECT Id,Person_1__c,Person_2__c FROM People_Tracing__c 
                                                                where (Person_1__c IN:personIds OR Person_2__c IN:personIds) 
                                                                AND Contact_Type__c ='Neighbour' AND 
                                                                (Person_1__r.Health_Status__c ='Green' OR 
                                                                Person_2__r.Health_Status__c ='Green') ];
                    set<id> Neighbour=new set<id>();
                    for(People_Tracing__c pt:personytracingrecords){
                      if(!alreadyprocessed.contains(pt.Person_1__c)){

                        Neighbour.add(pt.Person_1__c);
                        alreadyprocessed.add(pt.Person_1__c);

                      }
                        if(!alreadyprocessed.contains(pt.Person_2__c)){

                        Neighbour.add(pt.Person_2__c);
                        alreadyprocessed.add(pt.Person_2__c);


                      }

                    }
                    return Neighbour;
                  }

                  
                    public static set<id> Primaycontacts(set<id> personIds,set<id> alreadyprocessed){

                   List<String> Healthstatus=new List<String>{'Green','Yellow'};

                   list<People_Tracing__c> personytracingrecords=[SELECT Id,Person_1__c,Person_2__c FROM People_Tracing__c 
                                                                where (Person_1__c IN:personIds OR Person_2__c IN:personIds) 
                                                                AND Contact_Type__c ='Other' 
                                                                AND Contact_Date__c =LAST_N_DAYS:10 
                                                                AND (Person_1__r.Health_Status__c IN:Healthstatus 
                                                                OR Person_2__r.Health_Status__c IN:Healthstatus) ];
                                                                
                    set<id> Primaycontacts=new set<id>();
                    for(People_Tracing__c pt:personytracingrecords){
                      if(!alreadyprocessed.contains(pt.Person_1__c)){

                        Primaycontacts.add(pt.Person_1__c);
                        alreadyprocessed.add(pt.Person_1__c);
                        

                      }
                        if(!alreadyprocessed.contains(pt.Person_2__c)){

                        Primaycontacts.add(pt.Person_2__c);
                        alreadyprocessed.add(pt.Person_2__c);

                      }

                    }
                    return Primaycontacts;
                  }

                  public static set<id> SecondaryContacts(set<id> primaryContacts,set<id> alreadyprocessed){

                   //List<String> Healthstatus=new List<String>{'Green','Yellow'};

                   list<People_Tracing__c> personytracingrecords=[SELECT Id,Person_1__c,Person_2__c FROM People_Tracing__c 
                                                                where (Person_1__c IN:primaryContacts OR Person_2__c IN:primaryContacts) 
                                                                AND Contact_Type__c ='Other' 
                                                                AND Contact_Date__c =LAST_N_DAYS:10 
                                                                AND (Person_1__r.Health_Status__c = 'Green' OR Person_2__r.Health_Status__c = 'Green') ];
                                                                
                    set<id> SecondaryContacts=new set<id>();
                    for(People_Tracing__c pt:personytracingrecords){
                      if(!alreadyprocessed.contains(pt.Person_1__c)){

                        SecondaryContacts.add(pt.Person_1__c);
                        alreadyprocessed.add(pt.Person_1__c);

                      }
                        if(!alreadyprocessed.contains(pt.Person_2__c)){

                        SecondaryContacts.add(pt.Person_2__c);
                        alreadyprocessed.add(pt.Person_2__c);


                      }

                    }
                    return SecondaryContacts;

                  }
          


    }

