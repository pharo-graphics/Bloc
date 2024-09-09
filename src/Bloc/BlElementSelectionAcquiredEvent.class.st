"
Is sent when element gets inside of mouse selection rectangle or when the overlapping rectangle formed by element's bounds and selection rectangle changes.

Text containing elements should react on this event and select a corresponding portion of text within selection rectangle

"
Class {
	#name : #BlElementSelectionAcquiredEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'bounds'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementSelectionAcquiredEvent class >> disableIn: anObject [
	anObject disableSelectionAcquired
]

{ #category : #'api - enable / disable' }
BlElementSelectionAcquiredEvent class >> enableIn: anObject [
	anObject enableSelectionAcquired
]

{ #category : #'api - enable / disable' }
BlElementSelectionAcquiredEvent class >> wantedIn: anObject [
	^ anObject wantsSelectionAcquired
]

{ #category : #accessing }
BlElementSelectionAcquiredEvent >> bounds [
	"Return intersection between current selection rectangle and target's bounds.
	Note: for performance reasons we reuse the same bounds object for all events of this type!
	Do not modify or store returned bounds, instead make a #copy!"
	<return: #BlBounds>

	^ bounds
]

{ #category : #accessing }
BlElementSelectionAcquiredEvent >> bounds: aBlBounds [
	bounds := aBlBounds
]
