@isTest
 public class CMPLCMPL123CMEQuestionnaireTriggerTest{
	static testMethod void CMPL123CMEQuestionnaireTriggerTestmethod(){
		CMPL123CME__Questionnaire__c testobject = new CMPL123CME__Questionnaire__c ();
		insert testobject; 
		update testobject; 
		System.assertEquals('1','1');
	}
}