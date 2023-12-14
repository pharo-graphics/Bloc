Class {
	#name : 'BlDevScripterUserDataStorage',
	#superclass : 'BlDevScripterSetStepStorage',
	#instVars : [
		'key',
		'value'
	],
	#category : 'Bloc-Scripter-Scripter-Storage',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Storage'
}

{ #category : 'accessing' }
BlDevScripterUserDataStorage >> key [
	^ key
]

{ #category : 'accessing' }
BlDevScripterUserDataStorage >> key: anObject [
	key := anObject
]

{ #category : 'printing' }
BlDevScripterUserDataStorage >> printOn: aStream [
	self key ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Set Data: ';
		print: self key
]

{ #category : 'storing' }
BlDevScripterUserDataStorage >> storeFrom: aTarget scripter: aScripter [
	| aKey aValue |
	aKey := self key value.
	aValue := self value cull: aTarget cull: aScripter.
	aScripter userData at: aKey put: aValue.
]

{ #category : 'accessing' }
BlDevScripterUserDataStorage >> value [
	^ value
]

{ #category : 'accessing' }
BlDevScripterUserDataStorage >> value: anObject [
	value := anObject
]
