Class {
	#name : #BlDevHalosEventListener,
	#superclass : #BlElementEventListener,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'mouse handlers' }
BlDevHalosEventListener >> mouseDownEvent: anEvent [
	(anEvent modifiers isShift and: [ anEvent modifiers isAlt ])
		ifTrue: [ BlElementSelection on: anEvent target ]
]
