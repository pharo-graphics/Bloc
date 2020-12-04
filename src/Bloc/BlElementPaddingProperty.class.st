Class {
	#name : #BlElementPaddingProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'padding'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementPaddingProperty >> applyOnElement: anElement [
	anElement padding: self padding
]

{ #category : #accessing }
BlElementPaddingProperty >> padding [
	^ padding
]

{ #category : #accessing }
BlElementPaddingProperty >> padding: anObject [
	padding := anObject
]
