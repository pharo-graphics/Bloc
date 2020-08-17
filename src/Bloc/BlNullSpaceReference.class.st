Class {
	#name : #BlNullSpaceReference,
	#superclass : #BlSpaceReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space'
}

{ #category : #cleanup }
BlNullSpaceReference class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlNullSpaceReference class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
BlNullSpaceReference >> isNull [
	^ true
]
