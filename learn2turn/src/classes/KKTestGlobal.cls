public class KKTestGlobal {

	  public KKTestGlobal() {
	  	 learn2turn__Process_Job__c  myJob = new learn2turn__Process_Job__c();
	  }
	  
	  /*
    public  Database.QueryLocator start(Database.BatchableContext BC) {
    	datetime currentDateTime = System.now();

        return Database.getQueryLocator([SELECT Id
										FROM Process_Job___c 
										WHERE Process_Job_Master__r.Retryable_Via_Batchable__c = true
										AND ( Retry_After_Datetime__c = null OR Retry_After_Datetime__c < :currentTimeDate) 
										AND Status__c = 'Failed']);
    }
*/
    
}