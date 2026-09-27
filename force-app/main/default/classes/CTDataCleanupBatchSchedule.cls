public with sharing class CTDataCleanupBatchSchedule implements Schedulable {

    public static final String conExpres='0 0 3 * * ?';
    public void execute(SchedulableContext BC) {
        
        CTPeopleTracingDataCleanupBatch batchpeople =new CTPeopleTracingDataCleanupBatch();
        Database.executeBatch(batchpeople,2000);

        CTLocationTracingDataCleanupBatch batchlocation =new CTLocationTracingDataCleanupBatch();
        Database.executeBatch(batchlocation,2000);

    }

}
/* anonomys window
CTPeopleTracingDataCleanupBatchSchedule data=new CTPeopleTracingDataCleanupBatchSchedule();
System.Schedulable('dataclenaup',CTPeopleTracingDataCleanupBatchSchedule.conExpres,data); */