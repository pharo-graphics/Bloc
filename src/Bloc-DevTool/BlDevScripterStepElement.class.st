Class {
	#name : #BlDevScripterStepElement,
	#superclass : #BlElement,
	#instVars : [
		'labelElement',
		'targetElement'
	],
	#category : #'Bloc-DevTool-Scripter-UI'
}

{ #category : #'instance creation' }
BlDevScripterStepElement class >> newFromStep: aBlDevScripterStep [
	^ self new initializeFromStep: aBlDevScripterStep
]

{ #category : #initialization }
BlDevScripterStepElement >> initialize [
	super initialize.
	self 
		layout: BlLinearLayout vertical alignCenter;
		zIndex: 10;
		border: (BlBorder paint: Color black width: 2);
		background: Color white;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent.
			c padding: (BlInsets all: 5) ].

	self initializeLabelElement.
	self initializeTargetElement.
	self addChild: labelElement as: #label.
	self addChild: targetElement as: #target.
	
]

{ #category : #initialization }
BlDevScripterStepElement >> initializeFromStep: aBlDevScripterStep [
	| aStepText aTargetStep |
	self border: (BlBorder paint: aBlDevScripterStep labelColor width: 2).
	aStepText := aBlDevScripterStep gtDisplayText foreground: Color black.
	labelElement text: aStepText.
	aTargetStep := aBlDevScripterStep target gtDisplayText 
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

{ #category : #initialization }
BlDevScripterStepElement >> initializeTargetElement [
	targetElement := BlTextElement new 
		addEventHandlerOn: BlClickEvent do: [ :anEvent | BlEvent fireEvent: anEvent target: self ];
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent. ];
		text:  ('Target' asRopedText fontSize: 10; foreground: Color gray)
]
