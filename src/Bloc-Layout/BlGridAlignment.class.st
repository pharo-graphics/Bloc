Class {
	#name : #BlGridAlignment,
	#superclass : #Object,
	#pools : [
		'BlGridLayoutConstants'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #factory }
BlGridAlignment class >> baseline [
	^ BlGridBaselineAlignment uniqueInstance
]

{ #category : #factory }
BlGridAlignment class >> bottom [
	^ self trailing
]

{ #category : #factory }
BlGridAlignment class >> center [
	^ BlGridCenterAlignment uniqueInstance
]

{ #category : #cleanup }
BlGridAlignment class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #factory }
BlGridAlignment class >> end [
	^ self trailing
]

{ #category : #factory }
BlGridAlignment class >> fill [
	^ BlGridFillAlignment uniqueInstance
]

{ #category : #factory }
BlGridAlignment class >> leading [
	^ BlGridLeadingAlignment uniqueInstance
]

{ #category : #factory }
BlGridAlignment class >> left [
	^ self start
]

{ #category : #factory }
BlGridAlignment class >> right [
	^ self end
]

{ #category : #factory }
BlGridAlignment class >> start [
	^ self leading
]

{ #category : #factory }
BlGridAlignment class >> top [
	^ self leading
]

{ #category : #factory }
BlGridAlignment class >> trailing [
	^ BlGridTrailingAlignment uniqueInstance
]

{ #category : #factory }
BlGridAlignment class >> undefined [
	^ BlGridUndefinedAlignment uniqueInstance
]

{ #category : #accessing }
BlGridAlignment class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlGridAlignment >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #alignment }
BlGridAlignment >> alignmentValue: anElement viewSize: viewSize [
	"Returns an alignment value. In the case of vertical alignments the value
	returned should indicate the distance from the top of the view to the
	alignment location.
	
	For horizontal alignments measurement is made from the left edge of the component.

		view - the view to which this alignment should be applied
		viewSize - the measured size of the view"
	^ self subclassResponsibility
]

{ #category : #accessing }
BlGridAlignment >> bounds [
	^ BlGridLayoutBounds new
]

{ #category : #alignment }
BlGridAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlGridAlignment >> hash [
	^ self class hash
]

{ #category : #testing }
BlGridAlignment >> isFill [
	^ false
]

{ #category : #alignment }
BlGridAlignment >> sizeInCell: anElement viewSize: viewSize cellSize: cellSize [
	"Returns the size of the view specified by this alignment.
	In the case of vertical alignments this method should return a height; for
	horizontal alignments this method should return the width.

	The default implementation returns viewSize.
		anElement - an element to which this alignment should be applied
		viewSize - the measured size of the element
		cellSize - the size of the cell into which this element will be placed"
	^ viewSize
]
