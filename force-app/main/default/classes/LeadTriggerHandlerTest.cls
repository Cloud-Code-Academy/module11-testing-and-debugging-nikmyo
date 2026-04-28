@isTest
private class LeadTriggerHandlerTest {
    public static List<Lead> leads = new List<Lead>();
    public static final Integer numberOfVPs = 51;
    public static final Integer numberOfMgrs = 51;
    public static final Integer numberOfExecs = 50;
    public static final Integer numberOfAssts = 48;
    
    @TestSetup
    static void createTestData() {
        List<String> leadTitles = new List<String>{
            'vp',
            'v.p.',
            'vice president',
            'mgr',
            'manage',
            'head of department',
            'exec',
            'chief',
            'head',
            'assist',
            'deputy',
            'jr'
        };

        Integer listCounter = 0;
        Integer maxCounter = 12;

        for(Integer i = 0; i < 200; i++) {
            Lead l = new Lead();
            l.LastName = 'Test' + i;
            l.Company = 'Company ' + i;
            l.LeadSource = 'Other';
            l.Lead_Score__c = 0;
    
            if(listCounter < maxCounter) {
                l.Title = leadTitles.get(listCounter);
                listCounter++;
            }
            if(listCounter == maxCounter) {
                listCounter = 0;
            }
            leads.add(l);
        }

        insert leads;
    }

    /*
    @isTest
    static void testLeadTriggerHandler_handleTitleNormalization() {

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(leads);
        Test.stopTest();

        List<Lead> updatedTitleLeads = [SELECT Id, Title FROM Lead WHERE Id IN :leads];

        Integer vpCount = 0;
        Integer mgrCount = 0;
        Integer execCount = 0;
        Integer asstCount = 0;

        List<Integer> numberOfVPRecords = new List<Integer>();
        List<Integer> numberOfMgrRecords = new List<Integer>();
        List<Integer> numberOfExecRecords = new List<Integer>();
        List<Integer> numberOfAsstRecords = new List<Integer>();

        for(Lead l : updatedTitleLeads) {
            String title = l.Title != null ? l.Title.toLowerCase() : '';

            if(title.contains('vp') || title.contains('v.p.') || title.contains('vice president')) {
                    vpCount++;
                    numberOfVPRecords.add(vpCount);
                    // numberOfUpdatedRecords.set(0, vpCount++);
                }

            else if(title.contains('mgr') || title.contains('manage') || title.contains('head of department')) {
                    mgrCount++;
                    numberOfMgrRecords.add(mgrCount);
                    // numberOfUpdatedRecords.set(1, mgrCount++);
                }

            else if(title.contains('exec') || title.contains('chief') || title == 'head') {
                    execCount++;
                    numberOfExecRecords.add(execCount);
                    // numberOfUpdatedRecords.set(2, execCount++);
                }

            else if(title.contains('assist') || title.contains('deputy') || title.contains('jr')) {
                    asstCount++;
                    numberOfAsstRecords.add(asstCount);
                    // numberOfUpdatedRecords.set(3, asstCount++);
                }

            else{
                return;
            }
            }
            // numberOfUpdatedRecords.set(0, vpCount);
            // numberOfUpdatedRecords.set(1, mgrCount);
            // numberOfUpdatedRecords.set(2, execCount);
            // numberOfUpdatedRecords.set(3, asstCount);

        Assert.areEqual(numberOfVPs, numberOfVPRecords.size(), 'Expected number of VPs: ' + numberOfVPs);
        
        Assert.areEqual(numberOfMgrs, numberOfMgrRecords.size(), 'Expected number of Mgrs: ' + numberOfMgrs);

        Assert.areEqual(numberOfExecs, numberOfExecRecords.size(), 'Expected number of Execs: ' + numberOfExecs);

        Assert.areEqual(numberOfAssts, numberOfAsstRecords.size(), 'Expected number of Assts: ' + numberOfAssts);
    }
    */

    /*
    static void createTestData() {
        List<Lead> testVPLeads = new List<Lead>();

        testVPLeads.add(new Lead(
            LastName = 'Test 1',
            Company = 'Oceans 1',
            Title = 'vp'
        ));
        testVPLeads.add(new Lead(
            LastName = 'Test 2',
            Company = 'Oceans 2',
            Title = 'v.p.'
        ));
        testVPLeads.add(new Lead(
            LastName = 'Test 3',
            Company = 'Oceans 3',
            Title = 'vice president'
        ));

        List<Lead> testMgrLeads = new List<Lead>();

        testMgrLeads.add(new Lead(
            LastName = 'Test 4',
            Company = 'Oceans 4',
            Title = 'mgr'
        ));
        testMgrLeads.add(new Lead(
            LastName = 'Test 5',
            Company = 'Oceans 5',
            Title = 'manage'
        ));
        testMgrLeads.add(new Lead(
            LastName = 'Test 6',
            Company = 'Oceans 6',
            Title = 'head of department'
        ));

        List<Lead> testExecLeads = new List<Lead>();

        testExecLeads.add(new Lead(
            LastName = 'Test 7',
            Company = 'Oceans 7',
            Title = 'exec'
        ));
        testExecLeads.add(new Lead(
            LastName = 'Test 8',
            Company = 'Oceans 8',
            Title = 'chief'
        ));
        testExecLeads.add(new Lead(
            LastName = 'Test 9',
            Company = 'Oceans 9',
            Title = 'head'
        ));

        List<Lead> testAsstLeads = new List<Lead>();

        testAsstLeads.add(new Lead(
            LastName = 'Test 10',
            Company = 'Oceans 10',
            Title = 'assist'
        ));
        testAsstLeads.add(new Lead(
            LastName = 'Test 11',
            Company = 'Oceans 11',
            Title = 'deputy'
        ));
        testAsstLeads.add(new Lead(
            LastName = 'Test 12',
            Company = 'Oceans 12',
            Title = 'jr'
        ));

        insert testVPLeads;
        insert testMgrLeads;
        insert testExecLeads;
        insert testAsstLeads;
    }
    */

    
    @isTest
    static void testLeadTriggerHandler_handleTitleNormalizationVP() {
        // Query for Leads where Title like any of the specified variations of vice president
        List<Lead> vpLeads = [SELECT Id, Title FROM Lead WHERE Title LIKE '%vp%' OR Title LIKE '%v.p.%' OR Title LIKE '%vice president%'];
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(vpLeads);
        Test.stopTest();

        // Query for the updated Leads after handleTitleNormalization method runs
        List<Lead> updatedVPLeads = [SELECT Id FROM Lead WHERE Id IN :vpLeads];
        // Check if the expected number of Leads were updated
        Assert.areEqual(51, updatedVPLeads.size());
    }
    

    
    @isTest
    static void testLeadTriggerHandler_handleTitleNormalizationMgr() {
        List<Lead> mgrLeads = [SELECT Id, Title FROM Lead WHERE Title LIKE '%mgr%' OR Title LIKE '%manage%' OR Title LIKE '%head of department%'];
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(mgrLeads);
        Test.stopTest();

        List<Lead> updatedMgrLeads = [SELECT Id FROM Lead WHERE Id IN :mgrLeads];
        Assert.areEqual(51, updatedMgrLeads.size());
    }
    

    
    @isTest
    static void testLeadTriggerHandler_handleTitleNormalizationExec() {
        List<Lead> execLeads = [SELECT Id, Title FROM Lead WHERE Title LIKE '%exec%' OR Title LIKE '%chief%' OR Title LIKE '%head%'];
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(execLeads);
        Test.stopTest();

        List<Lead> updatedExecLeads = [SELECT Id FROM Lead WHERE Id IN :execLeads];
        Assert.areEqual(50, updatedExecLeads.size());
    }
    

    
    @isTest
    static void testLeadTriggerHandler_handleTitleNormalizationAsst() {
        List<Lead> asstLeads = [SELECT Id, Title FROM Lead WHERE Title LIKE '%assist%' OR Title LIKE '%deputy%' OR Title LIKE '%jr%'];
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(asstLeads);
        Test.stopTest();

        List<Lead> updatedAsstLeads = [SELECT Id FROM Lead WHERE Id IN :asstLeads];
        Assert.areEqual(48, updatedAsstLeads.size());
    }

    @isTest
    static void testLeadTriggerHandler_handleAutoLeadScoringWeb() {
        List<Lead> testLeads = [SELECT Id, LeadSource, Email, Lead_Score__c FROM Lead WHERE LeadSource != null AND Email != null];
        List<Lead> webEmailLeads = new List<Lead>();
        for(Lead l : testLeads) {
            l.LeadSource = 'Web';
            l.Email = 'iamalead@example.com';
            l.Lead_Score__c = 0;
            webEmailLeads.add(l);
        }
        
        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(webEmailLeads);
        Test.stopTest();

        List<Lead> scoredWebLeads = [SELECT Id, Lead_Score__c FROM Lead WHERE Id IN :webEmailLeads AND Lead_Score__c != null];
        List<Integer> webLeadScores = new List<Integer>();
        for(Lead l : scoredWebLeads) {
            webLeadScores.add(Integer.valueOf(l.Lead_Score__c));
        }

        if(!webLeadScores.isEmpty()) {
            Integer webLeadScore = webLeadScores.get(0);
            Assert.areEqual(3, webLeadScore);
        }
    }

    @isTest
    static void testLeadTriggerHandler_handleAutoLeadScoringPhone() {
        List<Lead> testLeads = [SELECT Id, LeadSource, Email, Phone, Lead_Score__c FROM Lead WHERE LeadSource != null AND Email != null AND Phone != null];
        List<Lead> phoneLeads = new List<Lead>();
        for(Lead l : testLeads) {
            l.LeadSource = 'Web';
            l.Email = 'iamalead@example.com';
            l.Lead_Score__c = 0;
            phoneLeads.add(l);
        }
        
        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(phoneLeads);
        Test.stopTest();

        List<Lead> scoredPhoneLeads = [SELECT Id, Lead_Score__c FROM Lead WHERE Id IN :phoneLeads AND Lead_Score__c != null];
        List<Integer> phoneLeadScores = new List<Integer>();
        for(Lead l : scoredPhoneLeads) {
            phoneLeadScores.add(Integer.valueOf(l.Lead_Score__c));
        }

        if(!phoneLeadScores.isEmpty()) {
            Integer phoneLeadScore = phoneLeadScores.get(0);
            Assert.areEqual(5, phoneLeadScore);
        }
    }

    @isTest
    static void testLeadTriggerHandler_handleAutoLeadScoringIndustry() {
        List<Lead> testLeads = [SELECT Id, LeadSource, Email, Phone, Industry, Lead_Score__c FROM Lead WHERE LeadSource != null AND Email != null AND Phone != null AND Industry != null];
        List<Lead> industryLeads = new List<Lead>();
        for(Lead l : testLeads) {
            l.LeadSource = 'Web';
            l.Email = 'iamalead@example.com';
            l.Industry = 'Technology';
            l.Lead_Score__c = 0;
            industryLeads.add(l);
        }
        
        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(industryLeads);
        Test.stopTest();

        List<Lead> scoredIndustryLeads = [SELECT Id, Lead_Score__c FROM Lead WHERE Id IN :industryLeads AND Lead_Score__c != null];
        List<Integer> industryLeadScores = new List<Integer>();
        for(Lead l : scoredIndustryLeads) {
            industryLeadScores.add(Integer.valueOf(l.Lead_Score__c));
        }

        if(!industryLeadScores.isEmpty()) {
            Integer industryLeadScore = industryLeadScores.get(0);
            Assert.areEqual(18, industryLeadScore);
        }
    }

    @isTest
    static void testLeadTriggerHandler_handleLeadAutoConvertWithOneContact() {
        List<Lead> testLeads = [SELECT Id, LastName, Email, Status FROM Lead WHERE Email != null];
        Set<String> leadEmails = new Set<String>();
        List<Contact> testContacts = new List<Contact>();
        for(String email : leadEmails) {
            Contact cont = new Contact();
            cont.LastName = 'Test';
            cont.Email = email;
            testContacts.add(cont);
        }
        insert testContacts;

        Test.startTest();
        LeadTriggerHandler.handleLeadAutoConvert(testLeads);
        Test.stopTest();

        List<Lead> convertedLeads = [SELECT Id, Status FROM Lead WHERE Id IN :testLeads AND Status = 'Closed - Converted'];
        List<String> leadStatus = new List<String>();
        if(!convertedLeads.isEmpty()) {
            for(Lead l : convertedLeads) {
            leadStatus.add(l.Status);
            }
        }
        String actualStatus = '';
        if(!leadStatus.isEmpty()) {
            actualStatus = leadStatus.get(0);
            Assert.areEqual('Closed - Converted', actualStatus);
        }
    }

    @isTest
    static void testLeadTriggerHandler_handleLeadAutoConvertWithMultipleContacts() {
        List<Lead> testLeads = [SELECT Id, LastName, Email, Status FROM Lead WHERE Email != null];
        Lead l1 = new Lead();
        l1.Email = 'iamatestlead@example.com';
        testLeads.add(l1);
        Lead l2 = new Lead();
        l2.Email = 'iamatestlead@example.com';
        testLeads.add(l2);
        List<String> leadEmails = new List<String>();
        List<Contact> testContacts = new List<Contact>();
        for(String email : leadEmails) {
            Contact cont = new Contact();
            cont.LastName = 'Test';
            cont.Email = email;
            testContacts.add(cont);
        }
        insert testContacts;

        Test.startTest();
        LeadTriggerHandler.handleLeadAutoConvert(testLeads);
        Test.stopTest();

        List<Lead> unconvertedLeads = [SELECT Id, Status FROM Lead WHERE Id IN :testLeads AND Status != 'Closed - Converted'];
        List<String> leadStatus = new List<String>();
        if(!unconvertedLeads.isEmpty()) {
            for(Lead l : unconvertedLeads) {
            leadStatus.add(l.Status);
            }
        }
        String actualStatus = '';
        if(!leadStatus.isEmpty()) {
            actualStatus = leadStatus.get(0);
            Assert.areNotEqual('Closed - Converted', actualStatus);
        }
    }
    
}