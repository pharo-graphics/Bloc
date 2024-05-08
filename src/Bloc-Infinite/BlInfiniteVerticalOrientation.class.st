Class {
	#name : #BlInfiniteVerticalOrientation,
	#superclass : #BlInfiniteLayoutOrientation,
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #testing }
BlInfiniteVerticalOrientation >> canScrollDown: anInfiniteElement [
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent bottom > (anInfiniteElement height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
BlInfiniteVerticalOrientation >> canScrollUp: anInfiniteElement [
	"Return true if an infinite element can be scrolled up"
	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position y < (anInfiniteElement layout paddingTop) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedEnd: anElement [
	^ (self layout decoratedBottom: anElement) + anElement constraints margin bottom
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedEndInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) bottom
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedMeasurement: anElement [
	^ (self layout decoratedMeasuredHeight: anElement) + anElement constraints margin height
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedMeasurementInOther: anElement [
	^ (self layout decoratedMeasuredWidth: anElement) + anElement constraints margin width
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedStart: anElement [
	^ (self layout decoratedTop: anElement) - anElement constraints margin top
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> decoratedStartInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) top
]

{ #category : #geometry }
BlInfiniteVerticalOrientation >> end [
	^ self layout height
]

{ #category : #geometry }
BlInfiniteVerticalOrientation >> endWithPadding [

	| height |
	height := self layout lastExactSize
		          ifNil: [ self layout height ]
		          ifNotNil: [ :size | size y ].

	^ (height max: self layout minimumHeight) - self layout paddingBottom
]

{ #category : #testing }
BlInfiniteVerticalOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
BlInfiniteVerticalOrientation >> isVertical [
	^ true
]

{ #category : #geometry }
BlInfiniteVerticalOrientation >> maximumSpace [
	"Return a number representing the maximum space. Here the maximum height."

	^ self layout maximumHeight
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> measurementSpec [
	^ self layout heightSpec
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> measurementSpecInOther [
	^ self layout widthSpec
]

{ #category : #'mouse handlers' }
BlInfiniteVerticalOrientation >> mouseWheelEvent: anEvent [
	| dY anInfiniteElement isHorizontal |

	anEvent vector isZero ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	isHorizontal ifTrue: [ ^ self ].

	dY := (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
				ifTrue: [ anEvent vector length ]
				ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
					ifTrue: [ anEvent vector length negated ]
					ifFalse: [ 0 ] ].

	dY isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (0 @ dY) * 200.
	anEvent consume
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> moveChild: anElement by: aNumber [
	anElement position: anElement position x @ (anElement position y + aNumber)
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> moveChildrenBy: aNumber [
	self layout offsetChildrenVerticallyBy: aNumber
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> paddingEnd [
	^ self layout paddingBottom
]

{ #category : #'children - geometry' }
BlInfiniteVerticalOrientation >> paddingStart [
	^ self layout paddingTop
]

{ #category : #geometry }
BlInfiniteVerticalOrientation >> startWithPadding [
	^ self layout paddingTop
]
