/*
*********************************************************
Apex Class Name    : AccountTriggerHandlerV2
Created Date       : May 10, 2023
@description       : This is the handler class for Account trigger V2
@author            : Arunkumar Kathiravan
*********************************************************
*/
public class AccountTriggerHandlerV2 implements ITriggerHandler{
    AccountTriggerHelper helper = new AccountTriggerHelper();
	/*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework before insert of the records
	@Parameters 	: List<sObject> newList
	*********************************************************
	*/
    public void beforeInsert(List<sObject> newList) {
        AccountTriggerHelper.validateAcntDataOnInsert(newList);
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework after insert of the records
	@Parameters 	: List<sObject> newList, Map<Id, sObject> newMap
	*********************************************************
	*/
    public void afterInsert(List<sObject> newList, Map<Id, sObject> newMap) {
        AccountTriggerHelper.createContacts(newList);
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework before update of the records
	@Parameters 	: List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap
	*********************************************************
	*/
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
        AccountTriggerHelper.validateAcntDataOnUpdate(newList, oldMap);
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework after update of the records
	@Parameters 	: List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap
	*********************************************************
	*/
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework before delete of the records
	@Parameters 	: List<sObject> oldList, Map<Id, sObject> oldMap
	*********************************************************
	*/ 
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework after delete of the records
	@Parameters 	: List<sObject> oldList, Map<Id, sObject> oldMap
	*********************************************************
	*/
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
    /*
	*********************************************************
	@Author 		: Arunkumar Kathiravan
	@CreatedDate 	: May 10, 2023
	@Description 	: Called by the trigger framework after undelete of the records
	@Parameters 	: List<sObject> newList, Map<Id, sObject> newMap
	*********************************************************
	*/
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }
}