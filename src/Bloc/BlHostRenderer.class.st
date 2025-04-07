"
Host renderer is resposible for the overall rendering logic

"
Class {
	#name : #BlHostRenderer,
	#superclass : #Object,
	#instVars : [
		'session',
		'surface',
		'surfaceRenderer',
		'spaceRenderer',
		'textMeasurer'
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

{ #category : #rendering }
BlHostRenderer >> finishedRender: aSpace [
	"Perform neccessary actions after rendering is complete.
	By default I clear dirty areas of a given space"

	aSpace clearDirtyElements
]

{ #category : #testing }
BlHostRenderer >> hasResized: aHostSpace [
	"Return true if host space resized since previous frame, otherwise false"
	
	"check if not initialized"
	self isValid ifFalse: [ ^ true ].
	
	"check if the size changed"
	^ aHostSpace physicalSize ~= surface physicalSize
		or: [ aHostSpace scaleFactor ~= surface scaleFactor ]
]

{ #category : #initialization }
BlHostRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	self subclassResponsibility
]

{ #category : #testing }
BlHostRenderer >> isValid [

	session == Smalltalk session
		ifFalse: [ ^ false ].

	(surface isNil
		or: [ surfaceRenderer isNil
			or: [ spaceRenderer isNil
				or: [ textMeasurer isNil ] ] ])
		ifTrue: [ ^ false ].
	
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

	| aSpace isRenderNeeded |
	self isValid ifFalse: [ ^ self ].

	aSpace := aHostSpace space.
	isRenderNeeded := aSpace hasDirtyElements.

	(surface shouldUpdateEveryFrame or: [ isRenderNeeded ])
		ifFalse: [ ^ self ].

	[ | theDamagedRectangles |
		aHostSpace makeCurrent.
		
		theDamagedRectangles := isRenderNeeded
			ifTrue: [ spaceRenderer renderSpace: aSpace ]
			ifFalse: [ #() ].

		surface performUpdates.

		surfaceRenderer renderSurface: surface damaged: theDamagedRectangles ]

			ensure: [ self finishedRender: aSpace ]
]

{ #category : #accessing }
BlHostRenderer >> spaceRenderer [

	^ spaceRenderer
]

{ #category : #accessing }
BlHostRenderer >> surface [

	^ surface
]

{ #category : #accessing }
BlHostRenderer >> surfaceRenderer [

	^ surfaceRenderer
]

{ #category : #accessing }
BlHostRenderer >> textMeasurer [

	^ textMeasurer
]
