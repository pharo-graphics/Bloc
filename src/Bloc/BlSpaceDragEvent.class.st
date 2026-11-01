Class {
	#name : #BlSpaceDragEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSpaceDragEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceDragEvent >> position: anObject [
	position := anObject
]
