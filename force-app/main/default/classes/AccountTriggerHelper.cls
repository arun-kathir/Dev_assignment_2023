/*
*********************************************************
Apex Class Name    : AccountTriggerHelper
Created Date       : May 10, 2023
@description       : This is the helper class for Account trigger handler V2
@author            : Arunkumar Kathiravan
*********************************************************
*/
public without sharing class AccountTriggerHelper {
	public AccountTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
    /*
    *********************************************************
    @Method Name    : createContacts
    @author         : Arunkumar Kathiravan
    @description    : method to is used to create 10 Child Contacts for each new Account by copying Account's phone into Contacts' phone
    @param          : Trigger.New
    @return         : NA
    ********************************************************
    */
    public static void createContacts(list<sObject> listAcntNew) {
        list<Contact> createChildContactsList = new list<Contact>();
        try{
            for(sObject sObj : listAcntNew){
                Account acnt = (Account)sObj;
                if(acnt.Name.containsIgnoreCase('BulkTest')){ //Verify whether Account name contains the text BulkTest
                    for(integer i=1; i<=10; i++){
                        if(Schema.sObjectType.Contact.isCreateable() && Schema.sObjectType.Contact.fields.Phone.isCreateable()){ //Verify whether running user has create access for Contact object
                            Contact con = new Contact(LastName = acnt.Name + ' ' + i, AccountId = acnt.id, Phone = acnt.Phone);
                            createChildContactsList.add(con);
                        }
                    }
                }
            }
        } 
        catch (Exception ex){
            system.debug('Exception message: ' + ex.getMessage());
        }
        if(!createChildContactsList.isEmpty()){
            try{
                //Create all child contacts
                Database.SaveResult[] lsr = Database.insert(createChildContactsList, true);
            } 
            catch (DMLException ex){
                system.debug('Exception message: ' + ex.getMessage());
            }
        }
    }
    /*
    *********************************************************
    @Method Name    : validateAcntDataOnInsert
    @author         : Arunkumar Kathiravan
    @description    : method to is used to restricting users from changing Billing Country to blank and Phone to an invalid format. Valid format is (xxx) xxx-xxxx.
    @param          : Trigger.New, Trigger.OldMap
    @return         : NA
    ********************************************************
    */    
    public static void validateAcntDataOnInsert(list<sObject> listAcntNew) {
        try{
            for(sObject sObj : listAcntNew){
                Account acnt = (Account)sObj;
                if(acnt.BillingCountry == null || String.isBlank(acnt.BillingCountry)){ //Verify Billing Country is changed to blank value
                    acnt.BillingCountry.addError('Billing Country cannot be blank'); //Error out when Billing country is blank
                }
                if(acnt.Phone != null && !String.isBlank(acnt.Phone)){
                    if(!Pattern.compile('^\\(\\d{3}\\)\\s\\d{3}-\\d{4}$').matcher(acnt.Phone).matches()){//Verify phone value is changed and it's format is (xxx) xxx-xxxx
                        acnt.Phone.addError('Invalid Phone Number format. Please ensure format is (xxx) xxx-xxxx'); //Error out when Phone format is invalid
                    }
                }
            }
        } 
        catch (Exception ex){
            system.debug('Exception message: ' + ex.getMessage());
        }
    }
    /*
    *********************************************************
    @Method Name    : validateAcntDataOnUpdate
    @author         : Arunkumar Kathiravan
    @description    : method to is used to restricting users from changing Billing Country to blank and Phone to an invalid format. Valid format is (xxx) xxx-xxxx.
    @param          : Trigger.New, Trigger.OldMap
    @return         : NA
    ********************************************************
    */    
    public static void validateAcntDataOnUpdate(list<sObject> listAcntNew, map<Id, sObject> mapAcntOld) {
        try{
            for(sObject sObj : listAcntNew){
                Account acnt = (Account)sObj;
                Account acntOld = (Account)mapAcntOld.get(acnt.id);
                if(acnt.BillingCountry != acntOld.BillingCountry && String.isBlank(acnt.BillingCountry)){ //Verify Billing Country is changed to blank value
                    acnt.BillingCountry.addError('Billing Country cannot be blank'); //Error out when Billing country is blank
                }
                if(acnt.Phone != acntOld.Phone && !String.isBlank(acnt.Phone)){
                    if(!Pattern.compile('^\\(\\d{3}\\)\\s\\d{3}-\\d{4}$').matcher(acnt.Phone).matches()){//Verify phone value is changed and it's format is (xxx) xxx-xxxx
                        acnt.Phone.addError('Invalid Phone Number format. Please ensure format is (xxx) xxx-xxxx'); //Error out when Phone format is invalid
                    }
                }
            }
        } 
        catch (Exception ex){
            system.debug('Exception message: ' + ex.getMessage());
        }
    }
}