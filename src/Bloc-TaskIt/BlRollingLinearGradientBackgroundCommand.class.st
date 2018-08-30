Class {
	#name : #BlRollingLinearGradientBackgroundCommand,
	#superclass : #BlRollingLinearGradientPaintCommand,
	#instVars : [
		'element'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #accessing }
BlRollingLinearGradientBackgroundCommand >> element [
	^ element
]

{ #category : #accessing }
BlRollingLinearGradientBackgroundCommand >> element: anObject [
	element := anObject
]

{ #category : #'api - execution' }
BlRollingLinearGradientBackgroundCommand >> execute [
	"Notice that I should be executed in a Bloc process"
	super execute.
	element background: paint.
]

{ #category : #'api - execution' }
BlRollingLinearGradientBackgroundCommand >> result [
	"Return a command execution result"
	<return: #Object>
	^ element
]
