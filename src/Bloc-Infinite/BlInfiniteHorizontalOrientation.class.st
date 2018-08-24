Class {
	#name : #BlInfiniteHorizontalOrientation,
	#superclass : #BlInfiniteLayoutOrientation,
	#category : 'Bloc-Infinite-Layout'
}

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
	^ self layout width - self layout paddingRight
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
	<return: #Number>

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
	^ self layout paddingLeft
]
