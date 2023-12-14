Class {
	#name : 'BlTaskAction',
	#superclass : 'BlTask',
	#instVars : [
		'action'
	],
	#category : 'Bloc-Space - Tasks',
	#package : 'Bloc',
	#tag : 'Space - Tasks'
}

{ #category : 'accessing' }
BlTaskAction >> action [
	^ action
]

{ #category : 'accessing' }
BlTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : 'initialization' }
BlTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : 'printing' }
BlTaskAction >> printOn: aStream [
	aStream
		print: self class name;
		space;
		nextPut: $(;
		print: self action;
		nextPut: $)
]

{ #category : 'running' }
BlTaskAction >> run [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]
