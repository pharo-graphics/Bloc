Class {
	#name : #BlInfiniteLinearLayoutState,
	#superclass : #Object,
	#instVars : [
		'allowRecycling',
		'availableSpace',
		'extraSpace',
		'currentPosition',
		'lastScrolledDelta',
		'itemDirection',
		'scrollingOffset',
		'isInfinite',
		'layoutDirection',
		'offset',
		'boundsUpdaterHasChanges'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Layout-Linear-Support'
}

{ #category : #accessing }
BlInfiniteLinearLayoutState >> allowRecycling [
	"Return true if recycling of children is allowed, false otherwise.
	We may not want to recycle children in some cases (e.g. layout)"
	<return: #Boolean>

	^ allowRecycling
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> allowRecycling: aBoolean [
	allowRecycling := aBoolean
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> availableSpace [
	"Amount of space that we should fill, in the layout direction"
	<return: #Number>

	^ availableSpace
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> availableSpace: aNumber in: aLayout [

	"uncomment if you get too many re-layouts.
	the actual available space value might slightly exceed maximum space, it is ok"
	"self
		assert: [ aNumber <= aLayout orientation maximumSpace ]
		description: [ 'Available space can not be greater that maximum space' ]."

	availableSpace := aNumber
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> boundsUpdaterHasChanges [

	^ boundsUpdaterHasChanges
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> boundsUpdaterHasChanges: aBoolean [

	boundsUpdaterHasChanges := aBoolean
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> clearScrollingOffset [

	scrollingOffset := Float negativeInfinity
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> currentPosition [
	"Current position on the data source to get the next item"
	<return: #Number>

	^ currentPosition
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> currentPosition: aNumber [
	currentPosition := aNumber
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> extraSpace [
	"Used if you want to pre-layout items that are not yet visible.
	The difference with availableSpace is that, when recycling, distance laid out for
   extraSpace is not considered to avoid recycling visible children"
	<return: #Number>
	
	^ extraSpace
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> extraSpace: aNumber [
	extraSpace := aNumber
]

{ #category : #testing }
BlInfiniteLinearLayoutState >> hasMoreItems: anInfiniteState [
	"Return true if there are more items in the data source"
	
	^ currentPosition between: 1 and: anInfiniteState itemCount
]

{ #category : #testing }
BlInfiniteLinearLayoutState >> hasScrollingOffset [

	^ scrollingOffset ~= Float negativeInfinity
]

{ #category : #initialization }
BlInfiniteLinearLayoutState >> initialize [
	super initialize.

	allowRecycling := true.
	offset := 0.
	availableSpace := 0.
	lastScrolledDelta := 0.
	boundsUpdaterHasChanges := false
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> isInfinite [
	"Return true if there is no limit in how many elements can be laid out"

	^ isInfinite
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> isInfinite: aBoolean [
	isInfinite := aBoolean
]

{ #category : #testing }
BlInfiniteLinearLayoutState >> isLayoutEndDirection [
	"Return true if the layout should be filled from the end"
	<return: #Boolean>

	^ layoutDirection isEnd
]

{ #category : #testing }
BlInfiniteLinearLayoutState >> isLayoutStartDirection [
	"Return true if the layout should be filled from the start"

	^ layoutDirection isStart
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> itemDirection [
	"Return the direction in which the data source is traversed"
	<return: #BlInfiniteLinearLayoutItemDirection>

	^ itemDirection
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> itemDirection: anItemDirection [
	itemDirection := anItemDirection
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> lastScrolledDelta [
	"Return the most recent #scrollBy: amount"
	<return: #Number>

	^ lastScrolledDelta
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> lastScrolledDelta: aNumber [
	lastScrolledDelta := aNumber
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> layoutDirection [
	"Return a direction in which the layout is filled."
	<return: #BlInfiniteLinearLayoutDirection>

	^ layoutDirection
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> layoutDirection: aLayoutDirection [
	layoutDirection := aLayoutDirection
]

{ #category : #recycling }
BlInfiniteLinearLayoutState >> nextElement: aRecycler in: anInfiniteElement [
	"Get the element for the next item that we should layout.
	Also update current item index to the next item, based on itemDirection."

	<return: #BlElement>
	| anElement |
	anElement := aRecycler
		             elementFor: currentPosition
		             in: anInfiniteElement.
	currentPosition := currentPosition + itemDirection multiplier.
	^ anElement
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> offset [
	"An offset where layout should start"
	<return: #Number>
	
	^ offset
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> scrollingOffset [
	"Return the amount (a number) of scrolling we can make without creating a new element.
	Taking me into account allows us to have efficient element recycling"
	
	^ scrollingOffset
]

{ #category : #accessing }
BlInfiniteLinearLayoutState >> scrollingOffset: aNumber [

	scrollingOffset := aNumber
]
