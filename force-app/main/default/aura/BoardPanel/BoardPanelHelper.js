({
    AddResultRecord : function(component, gameResult) {
        const action = component.get("c.addResult");
        const selectedMode = component.get("v.selectedmode");


        
        action.setParams({ 
           result : gameResult,
           mode : selectedMode,
        });

        action.setCallback(this, function(response) {
          const state = response.getState();
          if(state !== 'SUCCESS'){
            console.error("Error saving game result record", response.getError());
          }

        });

        $A.enqueueAction(action);
    },

showToast : function(title,message,type) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": title,
        "message": message,
        "type":type
    });
    toastEvent.fire();
}

})