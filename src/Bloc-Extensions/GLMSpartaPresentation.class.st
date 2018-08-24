"
This presentation offers a means to embed a Sparta Canvas and draw on it. It makes sense only for the Morph  Renderer.
"
Class {
	#name : #GLMSpartaPresentation,
	#superclass : #GLMPresentation,
	#traits : 'TGLMBlocPresentation',
	#classTraits : 'TGLMBlocPresentation classTrait',
	#instVars : [
		'extentBlock',
		'canvasBlock',
		'drawBlock'
	],
	#category : 'Bloc-Extensions-Presentations'
}

{ #category : #accessing }
GLMSpartaPresentation >> canvas [
	^ canvasBlock glamourValue: 
		(self asGlamorousMultiValue, 
		self displayValue asGlamorousMultiValue)
]

{ #category : #accessing }
GLMSpartaPresentation >> canvas: aBlock [
	canvasBlock := aBlock
]

{ #category : #accessing }
GLMSpartaPresentation >> draw: aBlock [
	drawBlock := aBlock
]

{ #category : #accessing }
GLMSpartaPresentation >> drawBlock [
	^ drawBlock
]

{ #category : #accessing }
GLMSpartaPresentation >> extent [
	^ extentBlock glamourValue: 
			(self asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue)
]

{ #category : #accessing }
GLMSpartaPresentation >> extent: aBlock [
	extentBlock := aBlock
]

{ #category : #initialization }
GLMSpartaPresentation >> initialize [
	super initialize.
	
	extentBlock := [ 600@400 ].
	canvasBlock := [ Bloc preferableSpartaCanvas ].
	drawBlock := [ :aCanvas | ]
]

{ #category : #testing }
GLMSpartaPresentation >> isAvailable [
	^ true
]

{ #category : #rendering }
GLMSpartaPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSpartaPresentation: self
]
