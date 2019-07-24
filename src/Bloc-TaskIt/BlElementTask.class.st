Class {
	#name : #BlElementTask,
	#superclass : #BlTask,
	#instVars : [
		'future'
	],
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlElementTask >> future [
	^ future
]

{ #category : #accessing }
BlElementTask >> future: anObject [
	future := anObject
]
