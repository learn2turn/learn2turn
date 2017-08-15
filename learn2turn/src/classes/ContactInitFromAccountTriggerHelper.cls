// This class initializes Contact otherer state and zip code based on the Account's billing address
//   provided niether already has a values.
//   It utilizes ContactAccountTriggerCache to hold all parent Accounts.
public without sharing class ContactInitFromAccountTriggerHelper  extends TriggerHelper2 {
	
	List<Contact>contactList;  // List of contacts for which we will set state and zipcode.
	
	// Constructor only needs to instantiate required instance variables.
	public ContactInitFromAccountTriggerHelper() {
		contactList = new List<Contact>();
	}
    
	// pre scan accumulates set of accountIds for all contacts 
    public void preScanRecord(Sobject newObj, Sobject oldObj) {
    	Contact contactObj = (Contact) newObj;
    	if (contactObj.accountId != null
    	&&  contactObj.otherState == null
    	&&  contactObj.otherPostalCode == null) {
    		ContactAccountTriggerCache.addId(contactObj.accountId);
    		contactList.add(contactObj);
    	}
    }  

    
	// post Process, assuming account is found, propagates account billing zip and state to Contact other zip and state.
    public void doPostProcess() {
    	
    	for (Contact contactObj : contactList) {
    		Account accountObj = ContactAccountTriggerCache.getAccount(contactObj.accountId);
    		if (accountObj != null) {
    			contactObj.otherState = accountObj.billingState;
    			contactObj.otherPostalCode = accountObj.billingPostalCode;
    		}
    	}
    
    }
    
    
} // end of class ContactInitFromAccountTriggerHelper