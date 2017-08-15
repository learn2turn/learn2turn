trigger KKTest_afterUpdate on learn2turn__KKTest__c (after update) {
    
    for (KKTest__c rec : Trigger.new) {
    	System.debug('after -- ' + rec);
    }
    
}