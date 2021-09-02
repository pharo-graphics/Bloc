"
This presentation offers a means to embed a Bloc element. It makes sense only for the Morph  Renderer.

"
Class {
	#name : 'GLMBlocPresentation',
	#superclass : 'GLMPresentation',
	#traits : 'TGLMBlocPresentation',
	#classTraits : 'TGLMBlocPresentation classTrait',
	#instVars : [
		'elementBuilder',
		'element'
	],
	#category : 'Bloc-Extensions-Presentations'
}

{ #category : 'requirements' }
GLMBlocPresentation >> element [
	^ element ifNil: [ 
		element := elementBuilder glamourValue: 
			(self asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue).
		element when: GLMBlocObjectToSelect do: [:signal | self selection: signal toSelect ] ]
]

{ #category : 'requirements' }
GLMBlocPresentation >> element: aBlock [
	elementBuilder := aBlock
]

{ #category : 'initialization' }
GLMBlocPresentation >> initialize [
	super initialize.
	elementBuilder := [ :thisPresentation :theDisplayValue | theDisplayValue asElement ]
]

{ #category : 'testing' }
GLMBlocPresentation >> isAvailable [
	^ true
]

{ #category : 'rendering' }
GLMBlocPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderBlocPresentation: self
]
