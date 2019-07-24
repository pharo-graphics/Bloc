Class {
	#name : #BlValuableCommand,
	#superclass : #BlCommand,
	#instVars : [
		'result',
		'valuable'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'api - execution' }
BlValuableCommand >> execute [
	result := self valuable value
]

{ #category : #accessing }
BlValuableCommand >> result [
	^ result
]

{ #category : #'api - execution' }
BlValuableCommand >> terminationRequested [
	"I silently ignore the cancel request as 
	I do not know how to cancel (terminate) a valuable object.
	You should implement a specialized command if you need to do so."
]

{ #category : #accessing }
BlValuableCommand >> valuable [
	"Return an object that understands value message"
	^ valuable
]

{ #category : #accessing }
BlValuableCommand >> valuable: anObject [
	"Set an object that understands value message"
	valuable := anObject
]

{ #category : #'api - testing' }
BlValuableCommand >> wasCanceled [
	"I cannot be canceled"
	^ false
]
