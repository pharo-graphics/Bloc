Class {
	#name : #BlElementBackgroundProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'background'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementBackgroundProperty >> applyOnElement: anElement [
	anElement background: self background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background [
	^ background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background: anObject [
	background := anObject
]
