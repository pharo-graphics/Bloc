Class {
	#name : #BlLayoutCommonConstraintsAxis,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'resizer'
	],
	#category : 'Bloc-Layouts-Basic'
}

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> exact: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber)
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> fitContentLimited [
	self resizer: BlLayoutResizer fitContentLimited
]

{ #category : #initialization }
BlLayoutCommonConstraintsAxis >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer exact: 50
]

{ #category : #resizing }
BlLayoutCommonConstraintsAxis >> matchParent [
	self resizer: BlLayoutResizer matchParent
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
