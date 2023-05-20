/*
*********************************************************
Apex Trigger Name  : AccountTrigger
Created Date       : May 7, 2023
@description       : This is the trigger for Account object
@author            : Arunkumar Kathiravan
*********************************************************
*/
trigger AccountTrigger on Account (before insert, after insert, before update, after update) {
    //Get the trigger active information from custom metadata by trigger name
    Boolean isActive = Trigger_Setting__mdt.getInstance('AccountTrigger')?.Active__c;
    if(isActive){
        system.debug('Runs AccountTrigger');
        if(trigger.isInsert){
            if(trigger.isAfter){
                AccountTriggerHandler.createContacts(trigger.new);
            }
            if(trigger.isBefore){
                AccountTriggerHandler.validateAcntDataOnInsert(trigger.new);
            }
        }
        if(trigger.isUpdate && trigger.isBefore){
            AccountTriggerHandler.validateAcntDataOnUpdate(trigger.new, trigger.OldMap);
        }
    }
}