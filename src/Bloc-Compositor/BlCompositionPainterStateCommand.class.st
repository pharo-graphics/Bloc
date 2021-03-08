Class {
	#name : #BlCompositionPainterStateCommand,
	#superclass : #Object,
	#instVars : [
		'offset'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #converting }
BlCompositionPainterStateCommand >> asSymbolTree [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlCompositionPainterStateCommand >> commandString [
	^ ''
]

{ #category : #'mathematical functions' }
BlCompositionPainterStateCommand >> multiplyOn: aBlMatrix2D [
	self subclassResponsibility
]

{ #category : #accessing }
BlCompositionPainterStateCommand >> offset [
	^ offset
]

{ #category : #accessing }
BlCompositionPainterStateCommand >> offset: anObject [
	offset := anObject
]

{ #category : #hook }
BlCompositionPainterStateCommand >> popOn: aCanvas [
	self subclassResponsibility
]

{ #category : #hook }
BlCompositionPainterStateCommand >> pushOn: aCanvas [
	self subclassResponsibility
]

{ #category : #hook }
BlCompositionPainterStateCommand >> pushOnLayer: aSkiaOffsetLayer [
	self subclassResponsibility
]

{ #category : #accessing }
BlCompositionPainterStateCommand >> type [
	^ 'Unknown'
]
