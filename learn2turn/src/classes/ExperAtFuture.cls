global class ExperAtFuture {
	
	public static @future void simpleAtFuture (String inStr) {
		
		System.debug ('simpleAtFuture inStr -- ' + inStr);
		
	}
    
    
    // This will not work.
    public static @future void nestedAtFuture (String inStr) {
		
		System.debug ('nestedAtFuture inStr -- ' + inStr);
		simpleAtFuture(inStr);  // This line will throw an Exception
		
	} 
	
	
}

/* 
 * Demo code
 *
  // This line in the syncronous process will succeed. A futureHandler will run and that will succeed.
 ExperAtFuture.simpleAtFuture('testme');

 // The syncronous process will succeed.  The process run by the future handlers will fail with Exception--
 //  System.AsyncException: Future method cannot be called from a future or batch method
 ExperAtFuture.nestedAtFuture('testme');
 
 *
 */