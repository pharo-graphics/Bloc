Class {
	#name : 'BlInfiniteLinearLayoutAnchorInfo',
	#superclass : 'Object',
	#instVars : [
		'position',
		'coordinate',
		'layoutFromEnd',
		'valid'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-Layout-Linear-Support',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear-Support'
}

{ #category : 'initialization' }
BlInfiniteLinearLayoutAnchorInfo >> assignCoordinateFromPaddingIn: aLinearLayout [ 
	| anOrientation |
	
	anOrientation := aLinearLayout orientation.
	coordinate := layoutFromEnd
		ifTrue: [ anOrientation endWithPadding ]
		ifFalse: [ anOrientation startWithPadding ]
]

{ #category : 'initialization' }
BlInfiniteLinearLayoutAnchorInfo >> assignFromElement: anElement in: aLinearLayout [
	| anOrientation | 
	anOrientation := aLinearLayout orientation.
	
	coordinate := layoutFromEnd
		ifTrue: [ (anOrientation decoratedEnd: anElement) + anOrientation totalSpaceChange ]
		ifFalse: [ anOrientation decoratedStart: anElement ].

	position := aLinearLayout childPositionOf: anElement
]

{ #category : 'initialization' }
BlInfiniteLinearLayoutAnchorInfo >> assignFromElementAndKeepVisible: anElement in: aLinearLayout [ 

	aLinearLayout orientation totalSpaceChange >= 0
		ifTrue: [ ^ self assignFromElement: anElement in: aLinearLayout ].
		
	position := aLinearLayout childPositionOf: anElement.

	layoutFromEnd
		ifTrue: [ self assignFromElementAndKeepVisibleFromStart: anElement in: aLinearLayout ]
		ifFalse: [ self assignFromElementAndKeepVisibleFromEnd: anElement in: aLinearLayout ].
]

{ #category : 'private' }
BlInfiniteLinearLayoutAnchorInfo >> assignFromElementAndKeepVisibleFromEnd: anElement in: aLinearLayout [ 
	| anOrientation aPreviousLayoutEnd aChildEnd aPreviousEndMargin |
	
	anOrientation := aLinearLayout orientation.

	aPreviousLayoutEnd := anOrientation endWithPadding - anOrientation totalSpaceChange.
	aChildEnd := anOrientation decoratedEnd: anElement.
	aPreviousEndMargin := aPreviousLayoutEnd - aChildEnd.
	
	coordinate := anOrientation endWithPadding - aPreviousEndMargin.
	
	"ensure we did not push child's top out of bounds because of this"
	aPreviousEndMargin > 0
		"we have room to shift bottom if necessary"
		ifTrue: [
			| aChildSize anEstimatedChildStart aLayoutStart aPreviousStartMargin aStartReference aStartMargin |
			aChildSize := anOrientation decoratedMeasurement: anElement.
			anEstimatedChildStart := coordinate - aChildSize.
			aLayoutStart := anOrientation startWithPadding.
			aPreviousStartMargin := (anOrientation decoratedStart: anElement) - aLayoutStart.
			aStartReference := aLayoutStart + (aPreviousStartMargin min: 0).
			aStartMargin := anEstimatedChildStart - aStartReference.
			aStartMargin < 0
				"offset to make top visible but not too much"
				ifTrue: [ coordinate := coordinate + (aPreviousEndMargin min: aStartMargin negated) ] ]
]

{ #category : 'private' }
BlInfiniteLinearLayoutAnchorInfo >> assignFromElementAndKeepVisibleFromStart: anElement in: aLinearLayout [ 
	| anOrientation aChildStart aStartMargin |
	
	anOrientation := aLinearLayout orientation.
	aChildStart := anOrientation decoratedStart: anElement.
	aStartMargin := aChildStart - anOrientation startWithPadding.
	
	coordinate := aChildStart.

	aStartMargin > 0
		"we have room to fix end as well"
		ifTrue: [ 
			| anEstimatedEnd aPreviousLayoutEnd aPreviousEndMargin anEndReference anEndMargin |
			anEstimatedEnd := aChildStart + (anOrientation decoratedMeasurement: anElement).
			aPreviousLayoutEnd := anOrientation endWithPadding - anOrientation totalSpaceChange.
			aPreviousEndMargin := aPreviousLayoutEnd - (anOrientation decoratedEnd: anElement).
			anEndReference := anOrientation endWithPadding - (aPreviousEndMargin min: 0).
			anEndMargin := anEndReference - anEstimatedEnd.
			anEndMargin < 0
				ifTrue: [ coordinate := coordinate - (aStartMargin min: anEndMargin negated) ] ]
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> coordinate [
	^ coordinate 
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> coordinate: aNumber [
	coordinate := aNumber 
]

{ #category : 'initialization' }
BlInfiniteLinearLayoutAnchorInfo >> initialize [
	super initialize.
	
	self reset 
]

{ #category : 'testing' }
BlInfiniteLinearLayoutAnchorInfo >> isElementValidAsAnchor: anElement state: anInfiniteState [
	| anInfiniteConstraints |
	
	anInfiniteConstraints := anElement constraints infinite.
	^ anInfiniteConstraints isItemRemoved not and: [
		anInfiniteConstraints elementLayoutPosition
			between: 1 
			and: anInfiniteState itemCount ]
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> isValid [
	^ valid 
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> isValid: aBoolean [ 

	valid := aBoolean
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> layoutFromEnd [
	^ layoutFromEnd 
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> layoutFromEnd: aBoolean [
	layoutFromEnd := aBoolean 
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> position [
	^ position 
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAnchorInfo >> position: aNumber [
	position := aNumber 
]

{ #category : 'initialization' }
BlInfiniteLinearLayoutAnchorInfo >> reset [
	position := NoPosition.
	coordinate := BlInfiniteLinearLayout invalidOffset.
	layoutFromEnd := false. 
	valid := false
]
