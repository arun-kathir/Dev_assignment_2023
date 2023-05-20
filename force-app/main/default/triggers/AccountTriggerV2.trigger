/*
*********************************************************
Apex Trigger Name  : AccountTriggerV2
Created Date       : May 10, 2023
@description       : This is the trigger for Account object after implementing Trigger Framework
@author            : Arunkumar Kathiravan
*********************************************************
*/
trigger AccountTriggerV2 on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
	system.debug('Runs AccountTriggerV2');
	TriggerDispatcher.run(new AccountTriggerHandlerV2(), 'AccountTriggerV2');
}