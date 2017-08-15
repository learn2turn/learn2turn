trigger Account_beforeUpdate on Account (before update) {
    
    // Instantiate required helpers
    AccountPostalCodeStateTriggerHelper postalCodeHelper = new AccountPostalCodeStateTriggerHelper();
    
    // pre-scan records
    for (Account newObj : trigger.new) {
    	Account oldObj = trigger.oldMap.get(newObj.id); 
    	postalCodeHelper.preScanRecord(newObj, oldObj);
    }
    
    // Do bulkified processing
    postalCodeHelper.doProcess();
    
    // No need to do individual record post scan
    
    // Do bulkified post processing
    postalCodeHelper.doPostProcess();
     
     
}  // end of trigger Account_beforeUpdate