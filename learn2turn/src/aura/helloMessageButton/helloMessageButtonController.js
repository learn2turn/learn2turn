({
    handleClick: function(component, event, helper) {
        var myButton = event.getSource();         // the button
        var myMessage = myButton.get("v.label"); // the button's label
        component.set("v.message", myMessage);     // update our message
    },
    handleClick1: function(component, event, helper) {
        var myMessage = event.getSource().get("v.label"); 
        component.set("v.message", myMessage);   
    },
    handleClick2: function(component, event, helper) {
        component.set("v.message", event.getSource().get("v.label"));   
    }
})