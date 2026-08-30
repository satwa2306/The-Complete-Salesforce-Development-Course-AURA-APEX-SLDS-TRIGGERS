({
    doInit : function(component, event, helper) {


        const gameMode=component.get("v.mode");

        let column=0;

        if(gameMode && gameMode==="hard"){
            column=6;
        }
        else if(gameMode==="medium"){

            column=4;
        }
        else{

            column=3;
        }

        let Blocksize=12/column;

        component.set("v.blocksize",Blocksize);

        const words=helper.getWords(column*column);
        component.set("v.words", words);


        const winWord=helper.getWinWord(words);
        component.set("v.winWord", winWord);

        helper.resetBoard(component);
        
    },
    doRender : function(component, event, helper) {

        /* console.log("doRender completed");
        */
    },

        blockclickHandler : function(component, event, helper) {

            let clickCount=component.get("v.clickCount") + 1;

            const  value=event.getParam("value");

            if(value === component.get("v.winWord")){

                component.set("v.result","YOU WON");
                
                helper.disableBoard(component);
                console.log(helper.disableBoard(component));
                helper.fireResultEvent("win");

            }
            else if(clickCount === 3){

                component.set("v.result","YOU LOSE");
             
                helper.disableBoard(component);
                helper.fireResultEvent("lose");
            }

            component.set("v.clickCount",clickCount);
            
    },

    reshuffleBoard:function(component, event, helper){

        const words=component.get("v.words");
        const randomizeWords=helper.randomizeArray(words);
        component.set("v.words",randomizeWords);
        helper.resetBoard(component);

        
    }





})