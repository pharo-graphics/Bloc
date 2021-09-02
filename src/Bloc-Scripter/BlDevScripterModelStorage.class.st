Class {
	#name : 'BlDevScripterModelStorage',
	#superclass : 'BlDevScripterSetStepStorage',
	#instVars : [
		'block'
	],
	#category : 'Bloc-Scripter-Scripter-Storage'
}

{ #category : 'accessing' }
BlDevScripterModelStorage >> block [
	^ block
]

{ #category : 'accessing' }
BlDevScripterModelStorage >> block: anObject [
	block := anObject
]

{ #category : 'printing' }
BlDevScripterModelStorage >> printOn: aStream [
	self block ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Set Model: ';
		print: self block
]

{ #category : 'storing' }
BlDevScripterModelStorage >> storeFrom: aTarget scripter: aScripter [
	| aModel |
	aModel := self block cull: aTarget cull: aScripter.
	aScripter model: aModel
]
