Class {
	#name : #BlCompositionPainterStateClip,
	#superclass : #BlCompositionPainterStateCommand,
	#instVars : [
		'clip'
	],
	#category : #'Bloc-Compositor-Painter'
}

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
