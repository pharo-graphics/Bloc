Class {
	#name : #BlDevScripterNestedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'targets'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #searching }
BlDevScripterNestedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aChild |
	
	aChild := anElement.
	self targets do: [ :eachTarget | 
		aChild := eachTarget findTargetIn: aChild ].
	^ aChild
]

{ #category : #'gt-extension' }
BlDevScripterNestedChildEventTarget >> gtTargetsFor: aView [
	<gtView>
	self targets ifNil: [ ^ aView empty ].
	^ (self targets gtItemsFor: aView)
		title: 'Targets'
]

{ #category : #printing }
BlDevScripterNestedChildEventTarget >> printOn: aStream [
	self targets ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: 'Child: { '.
	self targets 
		do: [ :eachTarget | aStream print: eachTarget identifier ] 
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' }'
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targetSequence: anArray [
	self targets: (anArray 
			collect: [ :eachTarget | BlDevScripterEventTarget targetInstanceFor: eachTarget ]
			as: Array)
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targets [
	^ targets
]

{ #category : #accessing }
BlDevScripterNestedChildEventTarget >> targets: anObject [
	targets := anObject
]
