"
I am a copy of class BlDevScripterCheckStep. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	target:		<Object>


    Implementation Points
"
Class {
	#name : #BlDevScripterStoreStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterStoreStep >> defaultLabel [
	^ 'Store'
]

{ #category : #initialization }
BlDevScripterStoreStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #actions }
BlDevScripterStoreStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetIn: aScripter element.
	self validateOn: anElement
]

{ #category : #'targets - accessing and updating' }
BlDevScripterStoreStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterStoreStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]

{ #category : #actions }
BlDevScripterStoreStep >> validateOn: anElement [
	"validate targeted element"
]
