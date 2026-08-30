({
    startgame : function(component, event, helper) {

        let gamecon=component.find("gameMode");

        let select= gamecon.get("v.value");

        component.set("v.selectedmode", select);

        if(select){

            const Boardcomp= component.find("startgame");
            Boardcomp.startGame();
        }

    },

        reshuffle : function(component, event, helper) {
            const Boardcomp= component.find("startgame");
             Boardcomp.reshuffle();
             component.set("v.disableButton",true);
    },

    onResultHandler :function(component,event,helper){

        const result=event.getParam("result");
        if(result=="win"){
            component.set("v.disableButton",true);
            helper.showToast("YOU WIN","HURRAY","success");
            
        }else{
            component.set("v.disableButton",false);
            helper.showToast("YOU LOSE","NICE TRY!","error");
        }
        helper.AddResultRecord(component, result);
        
    }


})