Class {
	#name : #BlBenchmarkConsole,
	#superclass : #BlElement,
	#instVars : [
		'fpsShape',
		'renderTimeShape',
		'eventProcessingShape',
		'layoutingShape'
	],
	#category : 'Bloc-DevTool-Core'
}

{ #category : #'as yet unclassified' }
BlBenchmarkConsole class >> on: aStage [
	^ self new
		listenSpace: aStage;
		yourself
]

{ #category : #benchmark }
BlBenchmarkConsole >> eventProcessingTime: aNumber [
	eventProcessingShape text: (BlRopedText string: 'event time: ', aNumber asString)
]

{ #category : #benchmark }
BlBenchmarkConsole >> fps: aNumber [
	fpsShape text: (BlRopedText string: 'fps: ', aNumber asString)
]

{ #category : #initialization }
BlBenchmarkConsole >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent.
		c padding: (BlInsets all: 5) ].
	
	self border:(BlBorder paint: Color black width: 2).
	self background: (Color white alpha: 0.9).
	
	fpsShape := BlTextElement new.
	fpsShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	renderTimeShape := BlTextElement new.
	renderTimeShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	eventProcessingShape := BlTextElement new.
	eventProcessingShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	layoutingShape := BlTextElement new.
	layoutingShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].

	self
		layout: (BlLinearLayout vertical);
		addChild: fpsShape;
		addChild: renderTimeShape
]

{ #category : #benchmark }
BlBenchmarkConsole >> layoutTime: aNumber [
	layoutingShape text: (BlRopedText string: 'layout time: ', aNumber asString)
]

{ #category : #initialization }
BlBenchmarkConsole >> listenSpace: aSpace [
	| lastTime frames framesLimit |
	lastTime := 0.
	frames := 0.
	framesLimit := 30.
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceRenderEndEvent do: [ :evt | 
				frames := frames + 1.
				frames % framesLimit = 0
					ifTrue: [
						self fps: (1000.0 /( ((evt end - lastTime) / framesLimit) max:1)) ceiling.
						lastTime := evt end.
						frames := 0 ].
				self renderTime: (evt end - evt start) ]).
	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceEventEndEvent do: [ :evt | 
					self eventProcessingTime: (evt end - evt start). 
					  ]).
  	aSpace eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceLayoutEndEvent do: [ :evt | 
					self layoutTime: (evt end - evt start). 
					  ])
]

{ #category : #benchmark }
BlBenchmarkConsole >> renderTime: aNumber [
	renderTimeShape text: (BlRopedText string: 'render time: ', aNumber asString)
]
