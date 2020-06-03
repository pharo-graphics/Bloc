Class {
	#name : #BlCompositionPainterStateClip,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'clip'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #comparing }
BlCompositionPainterStateClip >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ offset = anObject offset and: [ clip = anObject clip ]
]

{ #category : #accessing }
BlCompositionPainterStateClip >> clip [
	^ clip
]

{ #category : #accessing }
BlCompositionPainterStateClip >> clip: anObject [
	clip := anObject
]

{ #category : #accessing }
BlCompositionPainterStateClip >> commandString [
	^ self clip asString
]

{ #category : #comparing }
BlCompositionPainterStateClip >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ offset hash bitXor: clip hash
]

{ #category : #hook }
BlCompositionPainterStateClip >> pushOn: aCanvas [
	aCanvas clip push: clip offset: offset
]

{ #category : #hook }
BlCompositionPainterStateClip >> pushOnLayer: aSkiaOffsetLayer [	
	aSkiaOffsetLayer offset: self offset.
	self clip spartaClipOn: self with: aSkiaOffsetLayer
]

{ #category : #accessing }
BlCompositionPainterStateClip >> type [
	^ 'Clip'
]
