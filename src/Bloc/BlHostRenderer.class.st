"
Host renderer is resposible for the overall rendering logic

"
Class {
	#name : #BlHostRenderer,
	#superclass : #Object,
	#instVars : [
		'session',
		'textMeasurer',
		'physicalSize',
		'scaleFactor'
	],
	#classInstVars : [
		'preferableClass'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #settings }
BlHostRenderer class >> availableClasses [

	^ self allSubclasses
]

{ #category : #accessing }
BlHostRenderer class >> label [
	"Answer a human readable title to identify the class."

	^ self subclassResponsibility
]

{ #category : #'host - api' }
BlHostRenderer class >> newFormFrom: aBlElement [
	"Answer a `Form` with the received element rendered on it."

	^ self subclassResponsibility
]

{ #category : #'host - api' }
BlHostRenderer class >> offscreenMeasureTextParagraph: aBlTextParagraph [
	"Update the received paragraph with its measurement."

	^ self subclassResponsibility
]

{ #category : #settings }
BlHostRenderer class >> preferableClass [

	^ preferableClass ifNil: [
		self availableClasses ifNotEmpty: [ :ac |
			preferableClass := ac anyOne ] ]
]

{ #category : #settings }
BlHostRenderer class >> preferableClass: aBlHostRenderer [

	preferableClass := aBlHostRenderer
]

{ #category : #settings }
BlHostRenderer class >> settingsOn: aBuilder [
	<systemsettings>
	
	(aBuilder pickOne: #preferableClass)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 2;
		label: 'Preferable renderer';
		domainValues:
			(self availableClasses collect: [ :aHostRendererClass |
				aHostRendererClass label -> aHostRendererClass ]);
		description: 'Choose an option to render and measure text.'.

]

{ #category : #'host - api' }
BlHostRenderer class >> write: aBlElement asPngTo: aFileReference [
	"Draw the element into a PNG at the specified location."

	self subclassResponsibility
]

{ #category : #testing }
BlHostRenderer >> hasResized: aHostSpace [
	"Return true if host space resized since previous frame, otherwise false"
	
	"check if not initialized"
	self isValid ifFalse: [ ^ true ].
	
	"check if the size changed"
	^ aHostSpace physicalSize ~= physicalSize
		or: [ aHostSpace scaleFactor ~= scaleFactor ]
]

{ #category : #initialization }
BlHostRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be executed multiple times"
	
	self subclassResponsibility
]

{ #category : #testing }
BlHostRenderer >> isValid [

	session == Smalltalk session ifFalse: [ ^ false ].

	^ true
]

{ #category : #rendering }
BlHostRenderer >> measureTextParagraph: aBlTextParagraph [

	textMeasurer measureTextParagraph: aBlTextParagraph
]

{ #category : #rendering }
BlHostRenderer >> render: aHostSpace [
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window
	or canvas update."

	self subclassResponsibility
]

{ #category : #accessing }
BlHostRenderer >> textMeasurer [

	^ textMeasurer
]
