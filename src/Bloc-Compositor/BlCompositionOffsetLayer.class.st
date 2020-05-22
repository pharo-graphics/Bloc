Class {
	#name : #BlCompositionOffsetLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'offset'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #drawing }
BlCompositionOffsetLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas transform
		by: [ :t | t translateBy: self offset ]
		during: [ super drawOnSpartaCanvas: aCanvas ]
]

{ #category : #initialization }
BlCompositionOffsetLayer >> initialize [
	super initialize.
	
	offset := 0@0
]

{ #category : #accessing }
BlCompositionOffsetLayer >> name [
	^ 'Offset'
]

{ #category : #converting }
BlCompositionOffsetLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: self offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> offset [
	<return: #Number>

	^ offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> offset: aNumber [
	offset := aNumber
]
