"
I am a root class of all mouse buttons with a name, e.g. ""primary"", ""secondary"" or ""middle""

"
Class {
	#name : #BlMouseNamedButton,
	#superclass : #BlMouseButton,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Events'
}

{ #category : #cleanup }
BlMouseNamedButton class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlMouseNamedButton class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlMouseNamedButton >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	^ anotherObject isKindOf: self class
]

{ #category : #comparing }
BlMouseNamedButton >> hash [
	^ self class hash
]
