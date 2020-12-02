Class {
	#name : #BlElementBorderProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'border'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementBorderProperty >> applyOnElement: anElement [
	anElement border: self border
]

{ #category : #accessing }
BlElementBorderProperty >> border [
	^ border
]

{ #category : #accessing }
BlElementBorderProperty >> border: anObject [
	border := anObject
]
