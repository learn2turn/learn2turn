public with sharing class  KKTestController {
	
    public list<KKTest__c>kkTestList {get; set;}
    
    public class KKWrapper {
        public KKTest__c kktest {get; set;}
        public String    extraText {get; set;}
        KKWrapper (KKTest__c kk) {
            kktest = kk;
            extraText = kk.SimpleText__c;
        }
    }
    
    public list<KKWrapper> kkWrapperList {get; private set;}
    
    public KKTestController () {
        kkWrapperList = new list<KKWrapper>();
    	kkTestList = [ select id, name, SimpleText__c from KKTest__c ]    ;
        for (KKTest__c entry : KkTestList) {
            KKWrapper wrapper = new KKWrapper (entry);
            KKWrapperList.add(wrapper);
        }
    }
    
    public PageReference save() {
        update kkTestList;
        return null;
    }
    
}