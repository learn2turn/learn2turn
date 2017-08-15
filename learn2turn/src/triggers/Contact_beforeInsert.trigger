trigger Contact_beforeInsert on Contact (before insert) {
       
    
    // Instantiate required helpers
    ContactPostalCodeStateTriggerHelper postalCodeHelper = new ContactPostalCodeStateTriggerHelper();
    ContactInitFromAccountTriggerHelper initFromAccountHelper = new ContactInitFromAccountTriggerHelper();
    
    // pre-scan records, call each helpder's preScanRecord for each record in scope.
    for (Contact newObj : trigger.new) {
    	Contact oldObj = null; 
    	initFromAccountHelper.preScanRecord(newObj, oldObj);
    	postalCodeHelper.preScanRecord(newObj, oldObj);
    }
    
    // do bulkified processing
    postalCodeHelper.doProcess();
    
    // No need to do individual record post scan
    
    // Do bulkified post processing
    //  Init from Account must be first so values are set before zipcode/state validaiton.
    initFromAccountHelper.doPostProcess();
    postalCodeHelper.doPostProcess();
     
     
}