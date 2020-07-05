Class {
	#name : #BlDevScripterStepElement,
	#superclass : #BlElement,
	#instVars : [
		'labelElement',
		'targetElement',
		'statusElement'
	],
	#category : #'Bloc-DevTool-Scripter-UI'
}

{ #category : #'instance creation' }
BlDevScripterStepElement class >> newFromStep: aBlDevScripterStep [
	^ self new initializeFromStep: aBlDevScripterStep
]

{ #category : #initialization }
BlDevScripterStepElement >> initialize [
	| contents |
	super initialize.
	self 
		layout: BlLinearLayout horizontal;
		look: BrShadowLook;
		zIndex: 10;
		background: Color white;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	contents := BlElement new
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent.
			c padding: (BlInsets all: 5) ].
	self initializeStatusElement.
	self initializeLabelElement.
	self initializeTargetElement.
	self addChild: statusElement as: #status.
	self addChild: contents.
	contents addChild: labelElement as: #label.
	contents addChild: targetElement as: #target.
]

{ #category : #initialization }
BlDevScripterStepElement >> initializeFromStep: aBlDevScripterStep [
	| aStepText aTargetStep |
	statusElement background: aBlDevScripterStep stateColor.
	aStepText := aBlDevScripterStep gtDisplayText foreground: Color black.
	labelElement text: aStepText.
	aTargetStep := aBlDevScripterStep realTarget gtDisplayText 
		foreground: Color gray;
		fontSize: 10.
	targetElement text: aTargetStep.
]

{ #category : #initialization }
BlDevScripterStepElement >> initializeLabelElement [
	labelElement := BlTextElement new 
		zIndex: 10;
		background: Color white;
		addEventHandlerOn: BlClickEvent do: [ :anEvent | BlEvent fireEvent: anEvent target: self ];
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent. ];
		text: 'Step' asRopedText
]

{ #category : #accessing }
BlDevScripterStepElement >> initializeStatusElement [
	statusElement := BrVerticalPane new vMatchParent; hExact: 15; background: Color white
]

{ #category : #initialization }
BlDevScripterStepElement >> initializeTargetElement [
	targetElement := BlTextElement new 
		addEventHandlerOn: BlClickEvent do: [ :anEvent | BlEvent fireEvent: anEvent target: self ];
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent. ];
		text:  ('Target' asRopedText fontSize: 10; foreground: Color gray)
]
