trigger KKTest_beforeUpdate on learn2turn__KKTest__c (before update) {
    
	public static boolean defeatFlag = false;
	
    for (KKTest__c rec : Trigger.new) {
    	System.debug('before 1 -- ' + rec);
    	rec.SetByTrigger__c = rec.SetByTrigger__c + 10; 
    	System.debug('before 2  -- ' + rec);
    }
    
}