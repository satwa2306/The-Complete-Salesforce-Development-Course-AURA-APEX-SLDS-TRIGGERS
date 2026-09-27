public  class AsynBatchClass implements Database.Batchable<SObject> {

    set<id> leadRecordIds=new set<id>();

    public  AsynBatchClass(set<id> leadRecordIds){

        this.leadRecordIds=leadRecordIds;

    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator('select id,LeadSource from lead  WHERE Id IN :leadRecordIds');

    }

    public void execute(Database.BatchableContext BC,list<lead> scope){

        for(lead arc:scope){

            arc.LeadSource='Web';
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC){

        system.debug('batch excution finished');
    }


}
    /* AsynBatchClass leadnew=new AsynBatchClass();

    database.executebatch(leadnew,2); */

/* public Iterable<Lead> start(Database.BatchableContext BC) {

    List<Lead> leads = [
        SELECT Id, LeadSource
        FROM Lead
        WHERE LeadSource = 'Web'
    ];

    return leads;
} */