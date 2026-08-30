({
    tabselectHandler : function(component, event, helper) {
        const selectid= event.getParam("id");

        if(selectid ==="person"){
            component.set("v.HeaderTitle","Person View");

        }else{
            component.set("v.HeaderTitle","Location View");

        }
        component.set("v.Scope",selectid);
    }
})