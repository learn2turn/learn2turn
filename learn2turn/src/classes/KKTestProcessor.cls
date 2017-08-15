public class KKTestProcessor implements ProcessJobProcessor {

	// member variable for hold our result information
	private ProcessJob.ProcessJobResult result;
	
	// class and member variable for our parameter information.  What goes here depends on the job.
	public class KKTestProcessorInputInfo {
		String  myString;
		Decimal myDecimal;
		public KKTestProcessorInputInfo (String myString, Decimal myDecimal) {
			this.myString = myString;
			this.myDecimal = myDecimal;
		}
	}
	private KKTestProcessorInputInfo inputInfo;
	
	// Implementing class must implement an constructor with no arguments.
	public KKTestProcessor () {
		result = new ProcessJob.ProcessJobResult ();
	}
	
	// Implementing class must implement an init method.  This takes the place of passing parameters to constructor.
	public void init(String inputDataJSON) {
		if (inputDataJSON != null) {
			inputInfo = (KKTestProcessorInputInfo)JSON.deserialize(inputDataJSON,KKTestProcessorInputInfo.class);
		}
	}

	// Implementing class must implement process method to do the work.
	//   All business logic should be in this method.  The method should have a try/catch so no handled (no fatal) exceptions can occur.
	public 	void process() {
	  
	  try {
	  		
		System.debug('DEBUG: info -- ' + inputInfo); 
		// For demonstration randomly succeed or fail.  Probability of failure is equal to myDecimal, e.g., 0.25 is 25% change of failure 
		if (Math.random() > inputInfo.myDecimal) {
		  result.success = true;
		  result.message = 'It worked.';
		  result.details = 'It truly did.';
		} else {
		  result.success = false;
		  result.message = 'It did not work.';
		  result.details = 'Something went wrong.';
		}
		
	  } Catch (Exception ex) {
	  	result.success = false;
	  	result.retry = false;  // Indicates a fatal error such that the job should not automatically restart.
	  	result.message = 'Unhandled exception: ' + ex.getMessage();
	  	result.details = ex.getMessage() + '\n\n' + ex.getStackTraceString();	
	  }
	  
	} // end of process()
	
	// Implementing class must implement getResult method to return information about success or failure.
	public 	ProcessJob.ProcessJobResult getResult() {
		return result;
	}
	
	// Not part of the interface but it is encouraged for implementation class to write static that creates job for queueing and/or running in the current thread.
	
	// Create job for queueing.
	public static void queueJob(KKTestProcessorInputInfo inputInfo) {
		String jsonInput = JSON.serializePretty(inputInfo,true);
		ProcessJob myJob = new ProcessJob('KKTest', jsonInput);
		myJob.enqueue();	
	}
	
	// Create job for running in the current thread.
	public static void runJob(KKTestProcessorInputInfo inputInfo) {
		String jsonInput = JSON.serializePretty(inputInfo,true);
		ProcessJob myJob = new ProcessJob('KKTest', jsonInput);
		myJob.save();	
		myJob.process();
	}
	
	/* Ad-hoc apex to test job submission via queue 
	KKTestProcessor.KKTestProcessorInputInfo info = new KKTestProcessor.KKTestProcessorInputInfo('Test This', 0.5);
	KKTestProcessor.queueJob(info);
	*/
	
    /* Ad-hoc apex to test job submission via queue
	KKTestProcessor.KKTestProcessorInputInfo info = new KKTestProcessor.KKTestProcessorInputInfo('Test This', 0.5);
	KKTestProcessor.runJob(info);
	*/
	
	/* Test the version of the job defined for batch restart
  	    KKTestProcessor.KKTestProcessorInputInfo info = new KKTestProcessor.KKTestProcessorInputInfo('Test This', 0.5);
		String jsonInput = JSON.serializePretty(info,true);
		ProcessJob myJob = new ProcessJob('KKTestBatchable', jsonInput);
		myJob.save();	
		myJob.process(); 
	*/
	
} // end of class KKTestProcessor