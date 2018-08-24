Class {
	#name : #GLMBlocTextPresentation,
	#superclass : #GLMTextualPresentation,
	#traits : 'TGLMBlocPresentation',
	#classTraits : 'TGLMBlocPresentation classTrait',
	#category : 'Bloc-Extensions-Presentations'
}

{ #category : #rendering }
GLMBlocTextPresentation >> element [
	| element |
	
	element := self newEditorElement editor: (self newEditorModel text: self formatedDisplayValue asRopedText).
	element constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent.
		c padding: (BlInsets all: 10) ].
	^ element
]

{ #category : #initialization }
GLMBlocTextPresentation >> initialize [
	super initialize.

	self format: #yourself
]

{ #category : #testing }
GLMBlocTextPresentation >> isAvailable [
	^ self class environment hasClassNamed: #BrTextEditor
]

{ #category : #'instance creation' }
GLMBlocTextPresentation >> newEditorElement [
	^ (self class environment classNamed: #BrEditorElement) new
]

{ #category : #'instance creation' }
GLMBlocTextPresentation >> newEditorModel [
	^ (self class environment classNamed: #BrTextEditor) new
]

{ #category : #rendering }
GLMBlocTextPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderBlocTextPresentation: self
]
