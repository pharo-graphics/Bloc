Class {
	#name : #BlOnActionHandler,
	#superclass : #BlActionHandler,
	#instVars : [
		'action'
	],
	#category : 'Bloc-Events-Handler'
}

{ #category : 'as yet unclassified' }
BlOnActionHandler class >> do: aBlock [
	^ self new
		action: aBlock;
		yourself
]

{ #category : 'accessing' }
BlOnActionHandler >> action [
	^ action
]

{ #category : 'accessing' }
BlOnActionHandler >> action: anObject [
	action := anObject
]

{ #category : 'as yet unclassified' }
BlOnActionHandler >> actionPerformed [
	action value
]
