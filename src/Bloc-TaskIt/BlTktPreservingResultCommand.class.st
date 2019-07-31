Class {
	#name : #BlTktPreservingResultCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'result',
		'hasResult'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #converting }
BlTktPreservingResultCommand >> asResultPreservingCommand [
	<return: #BlTktPreservingResultCommand>
	^ self
]

{ #category : #evaluating }
BlTktPreservingResultCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self hasResult
		ifFalse: [ result := self command execute. hasResult := true. result ] 
		ifTrue: [ result ]
]

{ #category : #accessing }
BlTktPreservingResultCommand >> hasResult [
	<return: #Boolean>
	^ hasResult
]

{ #category : #initialization }
BlTktPreservingResultCommand >> initialize [
	super initialize.
	hasResult := false.
	result := nil.
]

{ #category : #accessing }
BlTktPreservingResultCommand >> name [
	<return: #String>
	^ 'Preserving result ', self name
]

{ #category : #accessing }
BlTktPreservingResultCommand >> result [
	^ result
]
