Class {
	#name : #BlTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlTaskAction >> action [
	^ action
]

{ #category : #accessing }
BlTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : #initialization }
BlTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : #running }
BlTaskAction >> run [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]
