public with sharing class autoupdateHealthScheduleBatch implements Schedulable {

    public static final String conExpres='0 0 3 * * ?';
    public void execute(schedulableContext BC) {

        AutoUpdatePersonHealth auto=new AutoUpdatePersonHealth();
        Database.executeBatch(auto,2000);


    }
}