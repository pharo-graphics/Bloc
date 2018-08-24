Class {
	#name : #BlAnimatedCursor,
	#superclass : #BlCursor,
	#instVars : [
		'images',
		'animation',
		'imgIndex'
	],
	#category : 'Bloc-Animation-Cursor'
}

{ #category : #'as yet unclassified' }
BlAnimatedCursor >> activateOn: aSpace [
	self images ifNil: [ ^ self ].
	self createAnimation
		onStepDo: [ self updateNextImageOn: aSpace ];
		start
]

{ #category : #'as yet unclassified' }
BlAnimatedCursor >> createAnimation [
	animation ifNotNil:[animation stop].
	imgIndex := 0.
	^ animation := BlAnimation new
		duration: 50;
		beInfinite;
		yourself
]

{ #category : #'as yet unclassified' }
BlAnimatedCursor >> deactivateOn: aSpace [
	animation ifNotNil: [ animation stop ]
]

{ #category : #accessing }
BlAnimatedCursor >> images [
	^ images
]

{ #category : #accessing }
BlAnimatedCursor >> images: anObject [
	images := anObject
]

{ #category : #'as yet unclassified' }
BlAnimatedCursor >> updateNextImageOn: aSpace [
	
	imgIndex := (imgIndex % images size) + 1.
	aSpace updateCursorImage: (images at: imgIndex).
]
