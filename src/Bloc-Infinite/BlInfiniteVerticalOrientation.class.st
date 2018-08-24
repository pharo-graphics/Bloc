Class {
	#name : #BlInfiniteVerticalOrientation,
	#superclass : #BlInfiniteLayoutOrientation,
	#category : 'Bloc-Infinite-Layout'
}

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
	^ self layout height - self layout paddingBottom
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
	<return: #Number>

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
