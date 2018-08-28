Class {
	#name : #BlTaskItTask,
	#superclass : #BlTask,
	#instVars : [
		'future'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #accessing }
BlTaskItTask >> future [
	^ future
]

{ #category : #accessing }
BlTaskItTask >> future: anObject [
	future := anObject
]
