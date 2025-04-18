Class {
	#name : #BlLayoutCommonConstraintsAxis,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'resizer'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> exact: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber asFloat)
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> fitContentLimited [
	self resizer: BlLayoutResizer fitContentLimited
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> fitContentLimitedOffset: aNumber [
	self resizer: (BlLayoutResizer fitContentLimitedOffset: aNumber)
]

{ #category : #initialization }
BlLayoutCommonConstraintsAxis >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer exact: 50.0
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> isExact [
	
	^ self resizer isExact 
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> isFitContent [
	
	^ self resizer isFitContent 
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> isMatchParent [
	
	^ self resizer isMatchParent 
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #accessing }
BlLayoutCommonConstraintsAxis >> requestedHeightIn: anElement [

	^ self resizer requestedHeightIn: anElement
]

{ #category : #accessing }
BlLayoutCommonConstraintsAxis >> requestedWidthIn: anElement [

	^ self resizer requestedWidthIn: anElement
]

{ #category : #accessing }
BlLayoutCommonConstraintsAxis >> resizer [
	<return: #BlLayoutResizer>

	^ resizer
]

{ #category : #accessing }
BlLayoutCommonConstraintsAxis >> resizer: aBlLayoutResizer [

	resizer := aBlLayoutResizer
]
