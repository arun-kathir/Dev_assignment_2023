/*
*********************************************************
Apex Class Name    : AccountTriggerTest
Created Date       : May 8, 2023
@description       : This is the test class for Account trigger & Account trigger handler
@author            : Arunkumar Kathiravan
*********************************************************
*/
@isTest
public class AccountTriggerTest {
    /*
    *********************************************************
    @Method Name    : testCreateChildConts
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test creating 10 Child Contacts for each new Account by copying Account's phone into Contacts' phone
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testCreateChildConts(){
        list<Account> listAcnt = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'BulkTest ' + i, Phone = '(111) 111-1111', BillingCountry = 'SG'));
        }
        if(!listAcnt.isEmpty()){
            Test.startTest();
            insert listAcnt;
            Test.stopTest();
            for(Account acnt : [select Name, Phone, (select Name, Phone from Contacts) from Account where ID IN: listAcnt]){
                if(acnt.Contacts != null){
                    System.assertEquals(10, acnt.Contacts.size(), 'Child Contacts are not created properly');
                    for(Contact cont : acnt.Contacts){
                        System.assertEquals(acnt.Phone, cont.Phone, 'Account phone is not copied to Contact phone');
                        System.assert(cont.Name.containsIgnoreCase(acnt.Name), 'Contact Name is not derived from Account Name');
                    }
                }
            }
        }
    }
    /*
    *********************************************************
    @Method Name    : testNotCreateChildConts
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test not creating 10 Child Contacts for each new Account without having 'BulkTest' in the name
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testNotCreateChildConts(){
        list<Account> listAcnt = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'Test ' + i, Phone = '(111) 111-1111', BillingCountry = 'SG'));
        }
        if(!listAcnt.isEmpty()){
            Test.startTest();
            insert listAcnt;
            Test.stopTest();
            for(Account acnt : [select Name, Phone, (select Name, Phone from Contacts) from Account where ID IN: listAcnt]){
                System.assertEquals(0, acnt.Contacts.size(), 'Child Contacts are created incorrectly');
            }
        }
    }
    /*
    *********************************************************
    @Method Name    : testUpdateAccountPhone
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test throwing error on invalid phone format
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testUpdateAccountPhone(){
        list<Account> listAcnt = new list<Account>();
        list<Account> listAcntUpd = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'Test ' + i, Phone = '(111) 111-1111', BillingCountry = 'SG'));
        }
        if(!listAcnt.isEmpty()){
            insert listAcnt;
            for(Account acnt : listAcnt){
                acnt.Phone = '2222222222';
                listAcntUpd.add(acnt);
            }
        }
        try{
            if(!listAcntUpd.isEmpty()){
                update listAcntUpd;
            }
        }
        catch(Exception ex){
            system.assert(ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), 'Not getting proper error');
            system.assert(ex.getMessage().contains('Invalid Phone Number format. Please ensure format is (xxx) xxx-xxxx'), 'Not getting proper error');
            system.assert(ex.getMessage().contains('Phone'), 'Not getting proper error');
        }
    }
    /*
    *********************************************************
    @Method Name    : testUpdateAccountPhoneOnInsert
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test throwing error on invalid phone format
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testUpdateAccountPhoneOnInsert(){
        list<Account> listAcnt = new list<Account>();
        list<Account> listAcntUpd = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'Test ' + i, Phone = '1111111111', BillingCountry = 'SG'));
        }
        if(!listAcnt.isEmpty()){
            try{
                insert listAcnt;
            }
            catch(Exception ex){
                system.assert(ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), 'Not getting proper error');
                system.assert(ex.getMessage().contains('Invalid Phone Number format. Please ensure format is (xxx) xxx-xxxx'), 'Not getting proper error');
                system.assert(ex.getMessage().contains('Phone'), 'Not getting proper error');
            }
        }
    }
    /*
    *********************************************************
    @Method Name    : testBlankBillingCountry
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test throwing error on blank billing country on Account Insert
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testBlankBillingCountry(){
        list<Account> listAcnt = new list<Account>();
        list<Account> listAcntUpd = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'Test ' + i, Phone = '(111) 111-1111'));
        }
        if(!listAcnt.isEmpty()){
            try{
                insert listAcnt;
            }
            catch(Exception ex){
                system.assert(ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), 'Not getting proper error');
                system.assert(ex.getMessage().contains('Billing Country cannot be blank'), 'Not getting proper error');
                system.assert(ex.getMessage().contains('BillingCountry'), 'Not getting proper error');
            }
        }
    }
    /*
    *********************************************************
    @Method Name    : testUpdateAccountBillingCountry
    @author         : Arunkumar Kathiravan
    @description    : method to is used to test throwing error on blank billing country
    @param          : NA
    @return         : NA
    ********************************************************
    */
    @isTest
    public static void testUpdateAccountBillingCountry(){
        list<Account> listAcnt = new list<Account>();
        list<Account> listAcntUpd = new list<Account>();
        for(integer i=1; i<=200; i++){
            listAcnt.add(new Account(Name = 'Test ' + i, BillingCountry = 'SG'));
        }
        if(!listAcnt.isEmpty()){
            insert listAcnt;
            for(Account acnt : listAcnt){
                acnt.BillingCountry = '';
                listAcntUpd.add(acnt);
            }
        }
        try{
            if(!listAcntUpd.isEmpty()){
                update listAcntUpd;
            }
        }
        catch(Exception ex){
            system.assert(ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), 'Not getting proper error');
            system.assert(ex.getMessage().contains('Billing Country cannot be blank'), 'Not getting proper error');
            system.assert(ex.getMessage().contains('BillingCountry'), 'Not getting proper error');
        }
    }
}