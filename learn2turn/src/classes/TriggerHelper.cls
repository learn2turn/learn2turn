public interface TriggerHelper {

	// Use constructor for any general setup entire scope.
	
	// Called once for each record in scope at beginning of trigger.
    void preScanRecord (SObject newObj, SObject oldObj);

    // Called once for entire scope.  Do bulkified work here.
    void doProcess();
  
    // Trigger may call this method once for each record after doProcess();
    //   Only use this if every record in scope must be processed.
    void postScanRecord (SObject newObj, SObject oldObj);
  
    // Called once at end of trigger.
    //   Use this if bulkified work is needed at end of trigger 
    //   or if the class has maintained subset of records that it needs to process.
    void doPostProcess();
  
}