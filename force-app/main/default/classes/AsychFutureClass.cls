public with sharing class AsychFutureClass {
    
    @future
    public static void LeadUpdate(List<id> leadRecordIds) {

        /* list <Lead> newRecords=new List<Leads>(); */

        List <lead> ExistingRecords=[SELECT id,Country,Company  from lead where id IN:leadRecordIds];

        For(lead arc:ExistingRecords){

            arc.Company='Wipro';

        }

        /* newRecords.add(arc); */

        update ExistingRecords;
    }


    @future

    public static void Createrecord() {

        lead newrecord=new lead(FirstName='satwa',LastName='kongara',Company='wipro');

        insert newrecord;
    }
}
/* map<id, lead> get1=new map<id, lead>([SELECT id,Country,Company,Name,Salutation,FirstName,LastName  from lead]);
AsychFutureClass.LeadUpdate(get1.keyset()); */