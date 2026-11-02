Class {
	#name : #BlSpaceDragEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'position'
	],
	#category : #Bloc
}

{ #category : #accessing }
BlSpaceDragEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceDragEvent >> position: anObject [
	position := anObject
]
