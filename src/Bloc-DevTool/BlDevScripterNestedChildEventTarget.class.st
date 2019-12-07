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
