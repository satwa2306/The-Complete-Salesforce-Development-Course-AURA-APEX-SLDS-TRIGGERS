/**
 * CTLocationController
 * Main controller class for Location__c object
 * @author Manish
 */
public with sharing class CTLocationController {

    /**
     * Get 100 location with recent status change
     * @return List<Location__c>
     */
    public static List<Location__c> getRecentStatusChanges(){
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, 
        Status_Update_Date__c, Status__c FROM Location__c 
        ORDER BY Status_Update_Date__c 
        DESC NULLS LAST LIMIT 100];
    }

    /**
     * Search a location by name, zipcode or address
     * @return List<Person__c>
     */
    public static List<Location__c> searchLocations(String searchTerm){
    // appending the wild card
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                FROM Location__c
                WHERE Name LIKE :searchTerm
                    OR Pincode__c LIKE :searchTerm
                    OR Address__c LIKE :searchTerm
                ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    /**
     * Search a location by id
     * @return Location__c
     */
    public static Location__c getLocationById(String locationId){
        List<Location__c> locations = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                    FROM Location__c 
                    WHERE Id =: locationId];
                    
        if(locations != null && locations.size() > 0){
            return locations[0];
        }
        return null;
    }

    public static void Updateredscore(set<id> locationids) {

        list<Location__c> Locationtoupdate=new list<Location__c>();
       AggregateResult[] redpeoplelocation= [select Location__c,COUNT(id) total FROM Location_Tracing__c  
       WHERE Person__r.Health_Status__c='Red'
        AND Visit_Date__c=LAST_N_DAYS:10 
        AND Location__c IN:locationids 
        GROUP BY Location__c];

        for( AggregateResult ar:redpeoplelocation){

            String locationid=String.valueof(ar.get('Location__c'));
            integer redscore=integer.valueof(ar.get('total'));
            String  redstatus=getstatus(redscore);

            Locationtoupdate.add(new Location__c(id=locationid,Red_Score__c=redscore,Status__c=redstatus));

        }

            if(Locationtoupdate != null && Locationtoupdate.size() > 0){
            update Locationtoupdate;
        }


            
        }
        
         public static String getStatus(Integer redscore) {
            if(redscore==0){

                return 'Green';

            }

            if(redscore<=5){

                return 'Yellow';

            }
           else if(redscore<=10){

                return 'Orange';

            }

            else{

            return 'Red';
            }
        

    }

            public static Map<String,Integer> getHealthStatusCountHeader() {
            AggregateResult[] statusCountPersonHealth=[SELECT Status__c, count(id) total FROM Location__c GROUP BY Status__c];

             Map<String,Integer> result=new Map<String,Integer>();

            if(statusCountPersonHealth !=null && statusCountPersonHealth.size()>0){
            for(AggregateResult ar:statusCountPersonHealth){

              result.put(String.valueOf(ar.get('Status__c')),Integer.valueOf(ar.get('total')));

            }
            return result;
    }
    return null;
  }  
    
}



