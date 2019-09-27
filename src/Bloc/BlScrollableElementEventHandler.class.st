Class {
	#name : #BlScrollableElementEventHandler,
	#superclass : #BlElementEventListener,
	#category : #'Bloc-Utilities - Scrolling'
}

{ #category : #'mouse handlers' }
BlScrollableElementEventHandler >> gestureScrollEvent: anEvent [
	| aScrollHappened |

	aScrollHappened := anEvent currentTarget scrollBy: anEvent vector * 400.
	anEvent consumed: aScrollHappened
]

{ #category : #'mouse handlers' }
BlScrollableElementEventHandler >> scrollEvent: anEvent [
	| aScrollHappened |
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	aScrollHappened := anEvent currentTarget scrollBy: anEvent vector * 20.
	anEvent consumed: aScrollHappened
]
