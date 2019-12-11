Class {
	#name : #BlDevScripterEventCenteredPosition,
	#superclass : #BlDevScripterEventPosition,
	#category : #'Bloc-DevTool-Scripter-Event Positions'
}

{ #category : #setup }
BlDevScripterEventCenteredPosition >> updateEventPosition: aBlEvent in: anElement [
	| aPosition |
	aPosition := anElement bounds inSpace center.
	aBlEvent position: aPosition.
]
