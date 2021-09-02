"
I am a copy of class BlDevScripterModelStorage. This comment is copied from there, and might not be entirely accurate

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
	block:		<Object>


    Implementation Points

"
Class {
	#name : 'BlDevScripterElementStorage',
	#superclass : 'BlDevScripterSetStepStorage',
	#instVars : [
		'block'
	],
	#category : 'Bloc-Scripter-Scripter-Storage'
}

{ #category : 'accessing' }
BlDevScripterElementStorage >> block [
	^ block
]

{ #category : 'accessing' }
BlDevScripterElementStorage >> block: anObject [
	block := anObject
]

{ #category : 'printing' }
BlDevScripterElementStorage >> printOn: aStream [
	self block ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Set Element: ';
		print: self block
]

{ #category : 'storing' }
BlDevScripterElementStorage >> storeFrom: aTarget scripter: aScripter [
	| anElement |
	anElement := self block cull: aTarget cull: aScripter.
	self 
		assert: [ anElement isKindOf: BlElement ] 
		description: [ 'An element must be stored' ].
	aScripter element: anElement.
	aScripter pulse.
]
