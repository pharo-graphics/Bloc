Class {
	#name : #BlDevScripterStoreElementInfoStep,
	#superclass : #BlDevScripterStoreStep,
	#instVars : [
		'key',
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterStoreElementInfoStep >> block [
	^ block
]

{ #category : #accessing }
BlDevScripterStoreElementInfoStep >> block: anObject [
	block := anObject
]

{ #category : #accessing }
BlDevScripterStoreElementInfoStep >> defaultLabel [
	^ self printString
]

{ #category : #accessing }
BlDevScripterStoreElementInfoStep >> key [
	^ key
]

{ #category : #accessing }
BlDevScripterStoreElementInfoStep >> key: anObject [
	key := anObject
]

{ #category : #actions }
BlDevScripterStoreElementInfoStep >> playOn: aScripter [
	| aTarget aValue |
	aTarget := self target findTargetIn: aScripter element.
	aValue := self block cull: aTarget.
	aScripter userData at: self key put: aValue
]

{ #category : #printing }
BlDevScripterStoreElementInfoStep >> printOn: aStream [
	self key ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Store: ';
		print: self key
]
