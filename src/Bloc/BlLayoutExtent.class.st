Class {
	#name : #BlLayoutExtent,
	#superclass : #Object,
	#instVars : [
		'width',
		'height',
		'transformation'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - converting' }
BlLayoutExtent >> asPoint [
	^ self width @ self height
]

{ #category : #accessing }
BlLayoutExtent >> height [
	^ height
]

{ #category : #accessing }
BlLayoutExtent >> height: anObject [
	height := anObject
]

{ #category : #'api - converting' }
BlLayoutExtent >> inLocal [
	<return: #BlLayoutExtentInLocal>

	^ self subclassResponsibility
]

{ #category : #'api - converting' }
BlLayoutExtent >> inParent [
	<return: #BlLayoutExtentInParent>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlLayoutExtent >> size: aPoint [
	self
		width: aPoint x;
		height: aPoint y
]

{ #category : #accessing }
BlLayoutExtent >> transformation [
	
]

{ #category : #accessing }
BlLayoutExtent >> transformation: anObject [
	transformation := anObject
]

{ #category : #accessing }
BlLayoutExtent >> width [
	^ width
]

{ #category : #accessing }
BlLayoutExtent >> width: anObject [
	width := anObject
]
