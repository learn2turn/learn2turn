// This class implements a validation on Contact that when the zipcode is specified, the state must agree
//   with the zipcode on both the mailing and other address.
public without sharing class ContactPostalCodeStateTriggerHelper extends TriggerHelper2 {

	private set<String>postalCodeSet;  // represents the postal codes we must fetch
	private map<String, String>postalCodeMap;  // maps postal codes to state code
	private list<Contact>contactList;  // List of Contacts that have one or both postal filled codes.
		
	// Constructor only needs to instantiate required instance variables.
	public ContactPostalCodeStateTriggerHelper() {
		postalCodeSet = new set<String>();
		postalCodeMap = new map<String, String>();
		contactList = new List<Contact>();
	}

    
    
	// pre scan checks if postal code is present and puts in set for query. 
    public void preScanRecord(Sobject newObj, Sobject oldObj) {
    	
    	Contact ContactObj = (Contact)newObj;
    	boolean processContact = false;
    	if (String.isNotBlank(ContactObj.OtherPostalCode)
    	&&  ContactObj.OtherPostalCode.length() >= 5) {
    		postalCodeSet.add(ContactObj.OtherPostalCode.left(5));
    		processContact = true;
    	}
    	if (String.isNotBlank(ContactObj.MailingPostalCode)
    	&&  ContactObj.MailingPostalCode.length() >= 5) {
    		postalCodeSet.add(ContactObj.MailingPostalCode.left(5));
    		processContact = true;
    	}
		if (processContact) {
			contactList.add(ContactObj);
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
    
	
	// postScan() is not needed so we do not implement. 
    
    
    // Post process will take only the Contact records we need and set any validation errors.
    public void doPostProcess() {
    	
    	for (Contact ContactObj : contactList) {
      	    if (String.isNotBlank(ContactObj.OtherPostalCode)
    	    &&  ContactObj.OtherPostalCode.length() >= 5) {
    	    	String state = postalCodeMap.get(ContactObj.OtherPostalCode.left(5));
    	    	if (String.isNotBlank(state)
    	    	&&  state != ContactObj.OtherState) {
    	    		String message = 'Other Postal Code ' +  ContactObj.OtherPostalCode + ' is in state '  + state
    	    		  + '; please enter correct state or change Other Postal Code';
    	    		ContactObj.OtherState.addError(message);
    	    	}
    	    }
      	    if (String.isNotBlank(ContactObj.MailingPostalCode)
    	    &&  ContactObj.MailingPostalCode.length() >= 5) {
    	    	String state = postalCodeMap.get(ContactObj.MailingPostalCode.left(5));
    	    	if (String.isNotBlank(state)
    	    	&&  state != ContactObj.MailingState) {
    	    		String message = 'Mailing Postal Code ' +  ContactObj.MailingPostalCode + ' is in state '  + state
    	    		  + ' please enter correct state or change Mailing Postal Code';
    	    		ContactObj.MailingState.addError(message);
    	    	}
    	    }
    	}
    	
    } // end of postProcess()
    
    
    
} // end of class ContactPostalCodeStateTriggerHelper