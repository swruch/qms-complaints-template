<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Extension_Request_Current_Due_Date_CC</fullName>
        <field>Current_Due_Date__c</field>
        <formula>Change_Control__r.Due_Date__c</formula>
        <name>Extension Request Current Due Date CC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Due_Date_CC</fullName>
        <field>Due_Date__c</field>
        <formula>Proposed_Due_Date__c</formula>
        <name>Update Due Date CC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Change_Control__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>ER - Send Tax to QA for CC</fullName>
        <actions>
            <name>Extension_Request_for_CC</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Extension Request Current Due Date Change Control</fullName>
        <actions>
            <name>Extension_Request_Current_Due_Date_CC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Due Date CC</fullName>
        <actions>
            <name>Update_Due_Date_CC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Extension_Request_Change_Control__c.CMPL123_WF_Action__c</field>
            <operation>equals</operation>
            <value>Approve</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Extension_Request_for_CC</fullName>
        <assignedTo>spartasupppharma@123.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Extension Request for CC</subject>
    </tasks>
</Workflow>
