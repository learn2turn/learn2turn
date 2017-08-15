@isTest private class ExperAtFutureTest {
	
	@testSetup static void methodName() {
		CommonDataTest.loadData();

    }
	
	static testMethod void myTest () {
		Test.startTest();
		ExperAtFuture.simpleAtFuture('testInput');
		Test.stopTest();
	} 
    
}