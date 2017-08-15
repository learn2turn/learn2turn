({
    
  getExpenses: function(component) {
        var action = component.get("c.getExpenses");
        var self = this;
        action.setCallback(this, function(parm) {
            component.set("v.expenses", parm.getReturnValue());
            self.updateTotal(component);
        });
        $A.enqueueAction(action);
    }
    
    , // interfunction delimiter
    
  updateTotal : function(component) {  
      var expenses = component.get("v.expenses");
      var total = 0;
      for(var i=0; i<expenses.length; i++){
          var e = expenses[i];
          total += e.learn2turn__Amount__c;
      }
      //Update counters
      component.set("v.total", total);
      component.set("v.exp", expenses.length);
    }

     , // interfunction delimiter

	createExpense: function(component, expense) {
      this.upsertExpense(component, expense, function(a) {
        var expenses = component.get("v.expenses");
        expenses.push(a.getReturnValue());
        component.set("v.expenses", expenses);
        this.updateTotal(component);
      });
	}

    , // interfunction delimiter

    
  	upsertExpense : function(component, expense, callback) {
      var action = component.get("c.saveExpense");
      action.setParams({ 
          "expense": expense
      });
      if (callback) {
          action.setCallback(this, callback);
      }
      $A.enqueueAction(action);
    }    
     , // interfunction delimiter

})