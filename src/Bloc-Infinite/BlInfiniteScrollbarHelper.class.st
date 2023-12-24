Class {
	#name : #BlInfiniteScrollbarHelper,
	#superclass : #Object,
	#instVars : [
		'state',
		'layout',
		'orientation',
		'startElement',
		'endElement',
		'smoothScrollbarEnabled',
		'isReversedLayout'
	],
	#category : 'Bloc-Infinite-Scroller'
}

{ #category : #scrollbar }
BlInfiniteScrollbarHelper >> computeScrollExtent [

	| anExtent |
	self isEmpty ifTrue: [ ^ 0 ]. 

	smoothScrollbarEnabled ifFalse: [
		(layout childPositionOf: startElement) -
		(layout childPositionOf: endElement) abs + 1 ].

	anExtent :=
		(orientation decoratedEnd: endElement) -
		(orientation decoratedStart: startElement).

	^ orientation totalSpace min: anExtent
]

{ #category : #scrollbar }
BlInfiniteScrollbarHelper >> computeScrollOffset [

	| startPosition endPosition minPosition maxPosition itemsBefore laidOutArea itemRange avgSizePerRow |
	self isEmpty ifTrue: [ ^ 0 ].

	startPosition := layout childPositionOf: startElement.
	endPosition := layout childPositionOf: endElement.

	minPosition := startPosition min: endPosition.
	maxPosition := startPosition max: endPosition.
	
	itemsBefore := isReversedLayout
		ifTrue: [ 0 max: (state itemCount - maxPosition - 1) ]
		ifFalse: [ 0 max: (minPosition - 1) ].
	
	smoothScrollbarEnabled ifFalse: [ ^ itemsBefore ].
	
	laidOutArea :=
		((orientation decoratedEnd: endElement) -
		(orientation decoratedStart: startElement)) abs.
	itemRange := (startPosition - endPosition) abs + 1.
	avgSizePerRow := (laidOutArea / itemRange) asFloat.
	
	^ (itemsBefore * avgSizePerRow) + (orientation startWithPadding - (orientation decoratedStart: startElement))
]

{ #category : #scrollbar }
BlInfiniteScrollbarHelper >> computeScrollRange [

	| laidOutArea laidOutRange |
	self isEmpty ifTrue: [ ^ 0 ].

	smoothScrollbarEnabled ifFalse: [ ^ state itemCount ].

	laidOutArea :=
		(orientation decoratedEnd: endElement) -
		(orientation decoratedStart: startElement).
	
	laidOutRange :=
		((layout childPositionOf: startElement) -
		(layout childPositionOf: endElement)) abs + 1.

	^ (laidOutArea / laidOutRange * state itemCount) asFloat
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> endElement [

	^ endElement
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> endElement: aBlElement [

	endElement := aBlElement
]

{ #category : #scrollbar }
BlInfiniteScrollbarHelper >> isEmpty [

	^ layout childrenCount isZero
		or: [ state itemCount isZero
			or: [ startElement isNil
				or: [ endElement isNil ] ] ]
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> isReversedLayout [

	^ isReversedLayout
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> isReversedLayout: aBoolean [

	isReversedLayout := aBoolean
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> layout [

	^ layout
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> layout: aBlInfiniteLayout [

	layout := aBlInfiniteLayout
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> orientation [

	^ orientation
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> orientation: anInfiniteLayoutOrientation [

	orientation := anInfiniteLayoutOrientation
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> smoothScrollbarEnabled [

	^ smoothScrollbarEnabled
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> smoothScrollbarEnabled: aBoolean [

	smoothScrollbarEnabled := aBoolean
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> startElement [

	^ startElement
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> startElement: aBlElement [

	startElement := aBlElement
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> state [

	^ state
]

{ #category : #accessing }
BlInfiniteScrollbarHelper >> state: aBlInfiniteState [

	state := aBlInfiniteState
]
