Class {
	#name : #BlCompositionPainterState,
	#superclass : #Object,
	#instVars : [
		'commands'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #'api - playback' }
BlCompositionPainterState >> applyOnCanvas: aCanvas [
	commands reverseDo: [ :eachCommand | eachCommand pushOn: aCanvas ]
]

{ #category : #'api - playback' }
BlCompositionPainterState >> applyOnLayer: aSkiaLayer [
	commands reverseDo: [ :eachCommand | eachCommand pushOnLayer: aSkiaLayer ]
]

{ #category : #'api - commands' }
BlCompositionPainterState >> commands [
	"Return a snapshot of current commands as an array"
	<return: #Array of: #BlCompositionPainterStateCommand>
	
	^ Array
		new: commands size
		streamContents: [ :aStream | commands reverseDo: [ :eachCommand | aStream nextPut: eachCommand ] ]
]

{ #category : #initialization }
BlCompositionPainterState >> initialize [
	super initialize.
	
	commands := Stack new
]

{ #category : #testing }
BlCompositionPainterState >> isEmpty [
	^ commands isEmpty
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pop [
	commands pop
]

{ #category : #copying }
BlCompositionPainterState >> postCopy [
	commands := commands copy
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushClip: aPath offset: anOffset [
	commands push: (BlCompositionPainterStateClip new clip: aPath; offset: anOffset)
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushTransform: aMatrix offset: anOffset [
	commands push: (BlCompositionPainterStateTransformation new matrix: aMatrix; offset: anOffset)
]
