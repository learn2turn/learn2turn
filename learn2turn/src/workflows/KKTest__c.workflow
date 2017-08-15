<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>KKTestSetByWorkflow</fullName>
        <description>increatemens set by workflow field by 100.</description>
        <field>SetByWorkflow__c</field>
        <formula>SetByWorkflow__c + 100</formula>
        <name>KKTestSetByWorkflow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>KKTestEmail</fullName>
        <active>false</active>
        <formula>1 = 1</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>KKTestWorkflow</fullName>
        <actions>
            <name>KKTestSetByWorkflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>1=1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
