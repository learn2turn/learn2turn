public class KKTestDaisyChainQueueable implements queueable {

/* To demonstrate run anonymous Apex --

Integer nextStep = 0;
KKTestDaisyChainQueueable nextStepQueueable = new KKTestDaisyChainQueueable(nextStep); 
System.enqueueJob(nextStepQueueable);
*/

	private final static Integer lastStep = 15;
	
	private Integer currentStep;
	
	public KKTestDaisyChainQueueable (integer step) {
		currentStep = step;
	}
	
	public void execute(QueueableContext context) {

		System.debug('DEBUG: currentStep-- ' + currentStep);
		System.debug('DEBUG: context-- ' + context);
        System.debug('getLimitAsyncCalls ' + Limits.getLimitAsyncCalls() );
        System.debug('getLimitCallouts ' + Limits.getLimitCallouts() );
        System.debug('getLimitFutureCalls ' + Limits.getLimitFutureCalls() );
       System.debug('gettLimitQueueableJobs ' + Limits.getLimitQueueableJobs() );
  			
		Integer nextstep = currentStep + 1;
		if (nextStep == lastStep) {
			return;
		}
		KKTestDaisyChainQueueable nextStepQueueable = new KKTestDaisyChainQueueable(nextStep);
		System.enqueueJob(nextStepQueueable);		
	}


}