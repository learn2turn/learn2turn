// This class maintains a cache of Account records used for all Contact trigger helper classes.
public without sharing class ContactAccountTriggerCache {
	
	
	private static set<id>accountIdSet;  // Stores the IDs of all accounts we need to load.
	private static map<id, Account>accountMap;   // Map of Accounts keyd by Account.id.
	
	
	// Each Contract trigger prescan method should call this method to add the Ids of Accounts that are needed.
	public static void addId(Id accountId) {
		if 	(accountIdSet == null) {
			accountIdSet = new Set<Id>();
		}
		accountIdSet.add(accountId);
	}
    
    
    // Method to execute query to load all needed Accounts.  
    //   The select list should contain the union of all Account fields needed by all Contact trigger helpers.
    //   This may be called explicitly or may deferred until the first getAccount() call arrives.
    public static void loadAccounts() {
    	accountMap = new Map<id,Account> ([ select Id, billingPostalCode, billingState
    									from Account
    									where id in :accountIdSet] );
    }  
    
	
	// Method to return an Account from the cache
	public static Account getAccount(ID accountId) {
		if (accountMap == null) {
			loadAccounts();
		}
		return accountMap.get(accountId);
	}
	
	
} // end of class ContactAccountTriggerCache