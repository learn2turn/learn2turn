({
    myUpdate: function(component, evt, helper) {
      var expense = component.get("v.expense");
      var updateEvent = $A.get("e.learn2turn:updateExpenseItem");
      updateEvent.setParams({ "expense": expense }).fire();
    }
})