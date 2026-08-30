({
    doInit : function(component, event, helper) {
                const columns= [
            { label: 'Game Number', fieldName: 'Name', type: 'text' },
            { label: 'Gamemode', fieldName: 'Mode__c', type: 'text' },
            { label: 'CreatedDate', fieldName: 'CreatedDate', type: 'date' },
            { label: 'Result', fieldName: 'Result__c', type: 'text' },

            ]
            component.set("v.columns",columns);

            helper.fetchResult(component);
    },

    onResultHandler:function(component, event, helper){

        helper.fetchResult(component);
    }
    
})