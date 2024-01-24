Class {
	#name : #BlElementLayoutResizerProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'resizer'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - layout resizeable' }
BlElementLayoutResizerProperty >> exact: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber)
]

{ #category : #'api - layout resizeable' }
BlElementLayoutResizerProperty >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #'api - layout resizeable' }
BlElementLayoutResizerProperty >> fitContentLimited [
	self resizer: BlLayoutResizer fitContentLimited
]

{ #category : #'api - layout resizeable' }
BlElementLayoutResizerProperty >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #accessing }
BlElementLayoutResizerProperty >> resizer [
	^ resizer
]

{ #category : #accessing }
BlElementLayoutResizerProperty >> resizer: anObject [
	resizer := anObject
]
