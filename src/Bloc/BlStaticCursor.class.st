Class {
	#name : #BlStaticCursor,
	#superclass : #BlCursor,
	#instVars : [
		'image'
	],
	#category : #'Bloc-Space'
}

{ #category : #'as yet unclassified' }
BlStaticCursor >> activateOn: aSpace [
	aSpace updateCursorImage: self image
]

{ #category : #accessing }
BlStaticCursor >> image [
	^ image
]

{ #category : #accessing }
BlStaticCursor >> image: anObject [
	image := anObject
]
