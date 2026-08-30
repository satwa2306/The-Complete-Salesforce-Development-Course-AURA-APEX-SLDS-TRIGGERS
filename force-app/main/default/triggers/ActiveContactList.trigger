trigger ActiveContactList on Contact (after insert, after update,after delete,after undelete) {

switch on Trigger.operationType{

when AFTER_INSERT{

for(contact con:trigger.new){

    if(string.isnotblank(con.accountid)){

      string Accountid=con.AccountId;

      List<AggregateResult> results=[SELECT accountid,count(id) totalconacts from contact where Active__c=true and 
                                      accountid=:Accountid GROUP BY accountid ];


      for(AggregateResult result:results){

          string accid=string.valueof(result.get('accountid'));
          integer totalcontacts=Integer.valueof(result.get('totalconacts'));


          account acc=new account(id=accid,Number_of_Active_contacts__c=totalcontacts);

          update acc;



      }
      

    
   




}

}

}


}

}




