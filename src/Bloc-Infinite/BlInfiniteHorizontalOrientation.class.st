Class {
	#name : #BlInfiniteHorizontalOrientation,
	#superclass : #BlInfiniteLayoutOrientation,
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #testing }
BlInfiniteHorizontalOrientation >> canScrollLeft: anInfiniteElement [
	"Return true if an infinite element can be scrolled left"
	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position x < (anInfiniteElement layout paddingLeft) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #testing }
BlInfiniteHorizontalOrientation >> canScrollRight: anInfiniteElement [
	"Return true if an infinite element can be scrolled to the right"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent right > (anInfiniteElement width - anInfiniteElement layout paddingRight) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedEnd: anElement [
	^ (self layout decoratedRight: anElement) + anElement constraints margin right
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedEndInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) right
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedMeasurement: anElement [
	^ (self layout decoratedMeasuredWidth: anElement) + anElement constraints margin width
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedMeasurementInOther: anElement [
	^ (self layout decoratedMeasuredHeight: anElement) + anElement constraints margin height
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedStart: anElement [
	^ (self layout decoratedLeft: anElement) - anElement constraints margin left
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> decoratedStartInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) left
]

{ #category : #geometry }
BlInfiniteHorizontalOrientation >> end [
	^ self layout width
]

{ #category : #geometry }
BlInfiniteHorizontalOrientation >> endWithPadding [

	| width |
	width := self layout lastExactExtent
		         ifNil: [ self layout width ]
		         ifNotNil: [ :extent | extent x ].

	^ (width max: self layout minimumWidth) - self layout paddingRight
]

{ #category : #testing }
BlInfiniteHorizontalOrientation >> isHorizontal [
	^ true
]

{ #category : #testing }
BlInfiniteHorizontalOrientation >> isVertical [
	^ false
]

{ #category : #geometry }
BlInfiniteHorizontalOrientation >> maximumSpace [
	"Return a number representing the maximum space. Here the maximum width."

	^ self layout maximumWidth
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> measurementSpec [
	^ self layout widthSpec
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> measurementSpecInOther [
	^ self layout heightSpec
]

{ #category : #'mouse handlers' }
BlInfiniteHorizontalOrientation >> mouseWheelEvent: anEvent [
	| dX anInfiniteElement isHorizontal |

	anEvent vector isZero
		ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	
	isHorizontal ifFalse: [ ^ self ].

	dX := (anEvent isScrollLeft and: [ self canScrollLeft: anInfiniteElement ])
				ifTrue: [ anEvent vector length negated ]
				ifFalse: [ (anEvent isScrollRight and: [ self canScrollRight: anInfiniteElement ])
					ifTrue: [ anEvent vector length ]
					ifFalse: [ 0 ] ].

	dX isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (dX @ 0) * 200.
	anEvent consume
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> moveChild: anElement by: aNumber [
	anElement position: (anElement position x + aNumber) @ anElement position y
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> moveChildrenBy: aNumber [
	self layout offsetChildrenHorizontallyBy: aNumber
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> paddingEnd [
	^ self layout paddingRight
]

{ #category : #'children - geometry' }
BlInfiniteHorizontalOrientation >> paddingStart [
	^ self layout paddingLeft
]

{ #category : #geometry }
BlInfiniteHorizontalOrientation >> startWithPadding [
	<return: #Number>

	^ self layout paddingLeft
]
