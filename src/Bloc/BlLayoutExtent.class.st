Class {
	#name : #BlLayoutExtent,
	#superclass : #Object,
	#instVars : [
		'width',
		'height'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - converting' }
BlLayoutExtent >> asPoint [
	^ self width @ self height
]

{ #category : #accessing }
BlLayoutExtent >> height [
	<return: #Number>

	^ height
]

{ #category : #accessing }
BlLayoutExtent >> height: aNumber [
	height := aNumber
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
BlLayoutExtent >> width [
	<return: #Number>

	^ width
]

{ #category : #accessing }
BlLayoutExtent >> width: aNumber [
	width := aNumber
]
