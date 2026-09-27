trigger OppWonTrigger on Opportunity (before insert, before update, after insert, after update) {

list<Opportunity> opp=trigger.new;

list<Task> taskRec=new List<Task>();

    switch on trigger.operationtype {

        when BEFORE_INSERT,BEFORE_UPDATE{
        for(Opportunity oppRec:opp){
            if(oppRec.StageName == 'Closed Won'){

                oppRec.NextStep ='OnBoard Contract';

                

            }

        }
        
        }



when AFTER_INSERT {
for(Opportunity oppRec:opp){
    if(oppRec.StageName == 'Closed Won'){

     Task tac=new task();
        tac.WhatId=oppRec.Id;
        tac.Subject='Engage a customer';
        tac.Priority='High';
        taskRec.add(tac);

        Task tac1=new task();
        tac1.WhatId=oppRec.Id;
        tac1.Subject='Schedule Welcome call ';
        tac1.Priority='High';
        taskRec.add(tac1);

        Task tac2=new task();
        tac2.WhatId=oppRec.Id;
        tac2.Subject='Write a Thankyou email';
        tac2.Priority='High';
        taskRec.add(tac2);

    }
}

insert taskRec;
}
        when AFTER_UPDATE {

        for(Opportunity oppRec:opp){
            
        if(oppRec.StageName == 'Closed Won' && trigger.oldMap.get(oppRec.id).StageName !='Closed Won'){
        
        Task tac=new task();
        tac.WhatId=oppRec.Id;
        tac.Subject='Engage a customer';
        tac.Priority='High';
        taskRec.add(tac);

        Task tac1=new task();
        tac1.WhatId=oppRec.Id;
        tac1.Subject='Schedule Welcome call ';
        tac1.Priority='High';
        taskRec.add(tac1);

        Task tac2=new task();
        tac2.WhatId=oppRec.Id;
        tac2.Subject='Write a Thankyou email';
        tac2.Priority='High';
        taskRec.add(tac2);

            }

        }
    insert taskRec;
    }
            
        }

    }


