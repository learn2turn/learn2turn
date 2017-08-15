global class ExperWebService {
    
    global class ExperInner {
    	webservice String item1;
    	webservice String item2;
    }
 
 	webservice static String doOperation (ExperInner inputInfo) {
 		return inputInfo.item1;
 	}   

}