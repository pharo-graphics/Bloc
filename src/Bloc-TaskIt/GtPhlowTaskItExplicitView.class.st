Class {
	#name : #GtPhlowTaskItExplicitView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #accessing }
GtPhlowTaskItExplicitView >> asElementDo: aBlock [
	| element |
	element := self taskElement.
	^ aBlock value: element
]

{ #category : #private }
GtPhlowTaskItExplicitView >> attach: aComputedElement toParentOf: aProgressElement [
	| aParent |
	self 
		assert: [ aProgressElement hasParent ]
		description: [ 'Progress element must have a parent' ].
	self 
		assert: [ aComputedElement notNil ]
		description: [ 'Computed element must be non-nil' ].
	aParent := aProgressElement parent.
	aProgressElement removeFromParent.
	aParent addChild: aComputedElement.
]

{ #category : #private }
GtPhlowTaskItExplicitView >> computeElement [
	^ [ stencilBuilder asElement ]
		on: Error
		do: [ :error | self errorElementFrom: error ]
]

{ #category : #private }
GtPhlowTaskItExplicitView >> errorElementFrom: anException [
	anException freeze.
	^ GtPhlowViewWithError new
		error: anException;
		asElementDo: [ :errorElement | errorElement ]
]

{ #category : #accessing }
GtPhlowTaskItExplicitView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #accessing }
GtPhlowTaskItExplicitView >> stencilBuilder [
	^ stencilBuilder
]

{ #category : #private }
GtPhlowTaskItExplicitView >> taskElement [
	| aProgressElement aTask |
	aProgressElement := BlElement new.
	aProgressElement 
		layout: BlFrameLayout new;
		addChild: (BlTextElement new 
			text: ('Rendering...' asRopedText 
				foreground: Color gray lighter;
				fontSize: 21);
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]).
	aProgressElement
		background: BlTransparentBackground new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aTask := BlCancellableTaskItAction new.
	aTask element: aProgressElement.
	aTask action: [ self computeElement ].
	aTask onRunEnqueueRepeatedAction: (BlRollingLinearGradientBackgroundCommand new element: aProgressElement).
	aTask onSuccessEnqueueAction: [ :aComputedElement | 
		self attach: aComputedElement toParentOf: aProgressElement ].
	aTask onFailureEnqueueAction: [ :anException | 
		| anErrorElement |
		anErrorElement := self errorElementFrom: anException.
		self attach: anErrorElement toParentOf: aProgressElement ].
	aProgressElement enqueueTask: aTask.
	^ aProgressElement
]

{ #category : #accessing }
GtPhlowTaskItExplicitView >> title [
	^ title
]

{ #category : #accessing }
GtPhlowTaskItExplicitView >> title: anObject [
	title := anObject
]
