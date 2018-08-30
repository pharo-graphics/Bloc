Class {
	#name : #BlTaskItTask,
	#superclass : #BlTask,
	#instVars : [
		'future'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #accessing }
BlTaskItTask >> future [
	^ future
]

{ #category : #accessing }
BlTaskItTask >> future: anObject [
	future := anObject
]
