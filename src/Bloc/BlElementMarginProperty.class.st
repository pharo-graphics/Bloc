Class {
	#name : #BlElementMarginProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'margin'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementMarginProperty >> applyOnElement: anElement [
	anElement margin: self margin
]

{ #category : #accessing }
BlElementMarginProperty >> margin [
	^ margin
]

{ #category : #accessing }
BlElementMarginProperty >> margin: anObject [
	margin := anObject
]
