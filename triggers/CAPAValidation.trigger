trigger CAPAValidation on CMPL123QMS__CAPA__c (before update)
{
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        set<Id> CAPAID = new set<id>();
        for(CMPL123QMS__CAPA__c CAPA : Trigger.New)
        {
            CAPAId.add(CAPA.id);
        }
        
        List<CAPA_Plan__c> CAPAPlanList = [select id,CMPL123_WF_Status__c,capa__c from CAPA_Plan__c where CAPA__c =: CAPAId];
        List<CAPA_Effectiveness_Check__c> effCheckList = [select id from CAPA_Effectiveness_Check__c where CAPA__c =: CAPAID];
        List<CAPA_Investigation__c>InvestList=[select id, CMPL123_WF_Status__c,CAPA__c from CAPA_Investigation__c where CAPA__c=:CAPAId];
        for(CMPL123QMS__CAPA__c CAPA : Trigger.New)
        {
            CMPL123QMS__CAPA__c newCAPAStatus = Trigger.newMap.get(CAPA.id);
            CMPL123QMS__CAPA__c oldCAPAStatus = Trigger.oldMap.get(CAPA.id);
            
            
            if(newCAPAStatus.CMPL123_WF_Status__c == 'Pending Approval - CAPA Action Plan' && 
                            oldCAPAStatus.CMPL123_WF_Status__c == 'In Planning - CAPA'
                    && CAPAPlanList.size() == 0)
            {
                CAPA.addError('You need to add atleast one CAPA Plan before submitting');
            }
          
            //E
            else if(effCheckList.size()>0 && 
                        CAPA.CMPL123_WF_Action__c == 'Submit Final Review - Effectiveness Check Not Required')
            {
                CAPA.addError('You cannot perform this action since Effectiveness Check(s) are defined for this record. You can perform *Verify Effectiveness - CAPA Action Plan* action.');
            }
            //for F
            else if(CAPA.Effectiveness_Check_Required__c == 'Yes' && CAPA.CMPL123_WF_Status__c == 'Closed - CAPA' && 
                (effCheckList.size() == 0))
            {
                CAPA.addError('You must add atleast one EC before closing');
            }
            // for H
            for(CAPA_Plan__c plan : CAPAPlanList)
            {
                if(plan.capa__c == capa.id && plan.CMPL123_WF_Status__c != 'Approved – CAPA Action Plan' && 
                        CAPA.CMPL123_WF_Status__c == 'Pending Implementation - CAPA Action Plan')
                {
                    CAPA.addError('You cannot change the status to implementation until you approve all the Plans');
                    break;
                }
            }
          //For A
             for(CAPA_Investigation__c invest : InvestList)
            {
                if(invest.capa__c == capa.id && invest.CMPL123_WF_Status__c != 'Completed - Done'&&invest.CMPL123_WF_Status__c != 'Canceled – Investigation' && 
                        CAPA.CMPL123_WF_Status__c == 'Review - CAPA')
                {
                    CAPA.addError('You cannot perform the action Submit for Review - CAPA until you Close all investigations');
                    break;
                }
            }
        }
    }
}