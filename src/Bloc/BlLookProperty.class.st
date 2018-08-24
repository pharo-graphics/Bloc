Class {
	#name : #BlLookProperty,
	#superclass : #BlObjectProperty,
	#instVars : [
		'invalidateBlock',
		'whenBlock'
	],
	#category : 'Bloc-Property'
}

{ #category : #'instance creation' }
BlLookProperty class >> on: anOwner named: aSymbol default: aValue invalidated: anInvalidatedBlock when: aWhenBlock [
	^ self new
		name: aSymbol;
		owner: anOwner;
		rawValue: aValue;
		invalidated: anInvalidatedBlock;
		when: aWhenBlock;
		yourself
]

{ #category : #initialization }
BlLookProperty >> initialize [
	super initialize.
	
	invalidateBlock := [  ].
	whenBlock := [ true ]
]

{ #category : #'change management' }
BlLookProperty >> invalidated [
	(whenBlock cull: self owner)
		ifTrue: [ invalidateBlock cull: self owner ]
]

{ #category : #scripting }
BlLookProperty >> invalidated: aBlock [
	invalidateBlock := aBlock
]

{ #category : #scripting }
BlLookProperty >> when: aBlock [
	whenBlock := aBlock
]
