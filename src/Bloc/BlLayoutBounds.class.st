Class {
	#name : #BlLayoutBounds,
	#superclass : #Object,
	#instVars : [
		'left',
		'top',
		'width',
		'height',
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutBounds >> asBounds [
	^ BlBounds
		left: left
		top: top
		right: left + width
		bottom: top + height
]

{ #category : #accessing }
BlLayoutBounds >> asRectangle [
	^ Rectangle
		left: left
		right: left + width
		top: top
		bottom: top + height
]

{ #category : #accessing }
BlLayoutBounds >> bottom [
	^ self top + self height
]

{ #category : #accessing }
BlLayoutBounds >> extent [
	^ self width @ self height
]

{ #category : #accessing }
BlLayoutBounds >> extent: aPoint [
	self
		width: aPoint x;
		height: aPoint y
]

{ #category : #accessing }
BlLayoutBounds >> height [
	^ height
]

{ #category : #accessing }
BlLayoutBounds >> height: anObject [
	height := anObject
]

{ #category : #'api - converting' }
BlLayoutBounds >> inLocal [
	<return: #BlLayoutBoundsInLocal>

	^ self subclassResponsibility
]

{ #category : #'api - converting' }
BlLayoutBounds >> inParent [
	<return: #BlLayoutBoundsInParent>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlLayoutBounds >> left [
	^ left
]

{ #category : #accessing }
BlLayoutBounds >> left: anObject [
	left := anObject
]

{ #category : #accessing }
BlLayoutBounds >> perimeter [
	^ (self width + self height) * 2
]

{ #category : #accessing }
BlLayoutBounds >> position: aPoint [
	self
		left: aPoint x;
		top: aPoint y
]

{ #category : #accessing }
BlLayoutBounds >> right [
	^ self left + self width
]

{ #category : #accessing }
BlLayoutBounds >> top [
	^ top
]

{ #category : #accessing }
BlLayoutBounds >> top: anObject [
	top := anObject
]

{ #category : #accessing }
BlLayoutBounds >> transformation [
	^ transformation
]

{ #category : #accessing }
BlLayoutBounds >> transformation: anObject [
	transformation := anObject
]

{ #category : #transformations }
BlLayoutBounds >> translateBy: aPoint [
	left := left + aPoint x.
	top := top + aPoint y
]

{ #category : #accessing }
BlLayoutBounds >> width [
	^ width
]

{ #category : #accessing }
BlLayoutBounds >> width: anObject [
	width := anObject
]
