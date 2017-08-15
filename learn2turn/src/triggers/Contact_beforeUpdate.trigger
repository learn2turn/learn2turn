trigger Contact_beforeUpdate on Contact (before update) {
    
    
    // Instantiate required helpers
    ContactPostalCodeStateTriggerHelper postalCodeHelper = new ContactPostalCodeStateTriggerHelper();
    
    // pre-scan records
    for (Contact newObj : trigger.new) {
    	Contact oldObj = trigger.oldMap.get(newObj.id); 
    	postalCodeHelper.preScanRecord(newObj, oldObj);
    }
    
    // Do bulkified processing
    postalCodeHelper.doProcess();
    
    // No need to do individual record post scan
    
    // Do bulkified post processing
    postalCodeHelper.doPostProcess();
     
     
}