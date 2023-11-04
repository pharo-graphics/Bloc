Class {
	#name : #BlGridFlexibility,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #factory }
BlGridFlexibility class >> canStretch [
	^ BlGridCanStretch uniqueInstance
]

{ #category : #cleanup }
BlGridFlexibility class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #factory }
BlGridFlexibility class >> inflexible [
	^ BlGridInflexible uniqueInstance
]

{ #category : #accessing }
BlGridFlexibility class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlGridFlexibility >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlGridFlexibility >> and: aFlexibility [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlGridFlexibility >> andCanStretch: aFlexibility [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlGridFlexibility >> andInflexible: aFlexibility [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlGridFlexibility >> hash [
	^ self class hash
]
