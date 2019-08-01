Class {
	#name : #BlTktRequest,
	#superclass : #Object,
	#instVars : [
		'terminate'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #initialization }
BlTktRequest >> initialize [
	super initialize.
	terminate := false.
]

{ #category : #testing }
BlTktRequest >> shouldTerminate [
	<return: #Boolean>
	^ terminate
]

{ #category : #requests }
BlTktRequest >> terminate [
	terminate := true
]
