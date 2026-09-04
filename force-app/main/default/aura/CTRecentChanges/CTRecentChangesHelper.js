({

    FetchRecentHealthChanges : function(componet,event,helper) {

        const action=componet.get("v.scope")==="person" ? componet.get("c.getRecentPersonHealthChanges") : componet.get("c.getRecentLocationHealthChanges");

        action.setCallback(this,function(response){

            const state=response.getState();

            if(state==="SUCCESS"){

                const rep=response.getReturnValue();
                componet.set("v.data",rep);
                componet.set("v.intialResponse",rep);

            }


        } );

        $A.enqueueAction(action);


    },

    
    searchRecord : function(componet,queryTerm) {

        const action=componet.get("v.scope")==="person" ? componet.get("c.searchPeople") : componet.get("c.searchLocations");

        action.setParams({

            searchterm:queryTerm

        });

        action.setCallback(this,function(response){

            const state=response.getState();

            if(state==="SUCCESS"){

                const rep=response.getReturnValue();
                if(rep && rep.length>0){
                    componet.set("v.data",rep);
                    
                    
                }
                
                componet.set("v.issearching",false)


            }


        } );

        $A.enqueueAction(action);


    },
})