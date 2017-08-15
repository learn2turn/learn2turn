// Implements a validation that state is in zipcode on Account object.
public without sharing class AccountPostalCodeStateTriggerHelper implements TriggerHelper {
	
	private set<String>postalCodeSet;  // represents the postal codes we must fetch
	private map<String, String>postalCodeMap;  // maps postal codes to state code
	private list<Account>accountList;  // List of accounts that have one or both postal filled codes.
	

	// Constructor only needs to instantiate required instance variables.
	public AccountPostalCodeStateTriggerHelper() {
		postalCodeSet = new set<String>();
		postalCodeMap = new map<String, String>();
		accountList = new List<Account>();
	}


	// pre scan checks if postal code is present and puts in set for query. 
    public void preScanRecord(Sobject newObj, Sobject oldObj) {
    	
    	Account accountObj = (Account)newObj;
    	boolean processAccount = false;
    	if (String.isNotBlank(accountObj.billingPostalCode)
    	&&  accountObj.billingPostalCode.length() >= 5) {
    		postalCodeSet.add(accountObj.billingPostalCode.left(5));
    		processAccount = true;
    	}
    	if (String.isNotBlank(accountObj.shippingPostalCode)
    	&&  accountObj.shippingPostalCode.length() >= 5) {
    		postalCodeSet.add(accountObj.shippingPostalCode.left(5));
    		processAccount = true;
    	}
		if (processAccount) {
			accountList.add(accountObj);
		}
	    	
    } // end of preScanRecord()
     
    
    // Do process does the bulkfied work querying for zip codes.
    public void doProcess() {
    	
    	for (Zipcode__c zipRecord : [ select id, name, State_Code__c 
    									from Zipcode__c
    									where name in :postalCodeSet ]) {
    		postalCodeMap.put(zipRecord.name, zipRecord.State_Code__c);									
    	}
    	
    } // end of doProces()
    
	
	// post scan is not needed so we simply implement a dummy method. 
    public void postScanRecord(Sobject newObj, Sobject oldObj) {
    } // end of postScanRecord()
    
    
    // Post process will take only the Account records we need and set any validation errors.
    public void doPostProcess() {
    	
    	for (Account accountObj : accountList) {
      	    if (String.isNotBlank(accountObj.billingPostalCode)
    	    &&  accountObj.billingPostalCode.length() >= 5) {
    	    	String state = postalCodeMap.get(accountObj.billingPostalCode.left(5));
    	    	if (String.isNotBlank(state)
    	    	&&  state != accountObj.billingState) {
    	    		String message = 'Billing Postal Code ' +  accountObj.billingPostalCode + ' is in state '  + state
    	    		  + '; please enter correct state or change Billing Postal Code';
    	    		accountObj.billingState.addError(message);
    	    	}
    	    }
      	    if (String.isNotBlank(accountObj.shippingPostalCode)
    	    &&  accountObj.shippingPostalCode.length() >= 5) {
    	    	String state = postalCodeMap.get(accountObj.shippingPostalCode.left(5));
    	    	if (String.isNotBlank(state)
    	    	&&  state != accountObj.shippingState) {
    	    		String message = 'shipping Postal Code ' +  accountObj.shippingPostalCode + ' is in state '  + state
    	    		  + ' please enter correct state or change shipping Postal Code';
    	    		accountObj.shippingState.addError(message);
    	    	}
    	    }
    	}
    	
    } // end of postProcess()
    
    
}  // end of class AccountPostalCodeStateTriggerHelper