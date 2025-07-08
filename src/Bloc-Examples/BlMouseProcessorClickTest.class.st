Class {
	#name : #BlMouseProcessorClickTest,
	#superclass : #TestCase,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Examples-Event-Scripter'
}

{ #category : #running }
BlMouseProcessorClickTest >> newScripterElement [

	^ BlEventCountingElement new
		  extent: 100 @ 75;
		  position: 50 @ 50;
		  yourself
]

{ #category : #running }
BlMouseProcessorClickTest >> setUp [

	super setUp.

	scripter := BlDevScripter new.
	scripter element: self newScripterElement
]

{ #category : #tests }
BlMouseProcessorClickTest >> testClick [

	scripter substeps: 'Click' do: [ :aStep |
		aStep mouseMove by: 70 @ 60. "enter"
		aStep mouseDown.
		aStep mouseUp.

		aStep check
			label: 'Check last click event is not nil';
			satisfies: [ :aMouseProcessor |
				aMouseProcessor lastClickEvent isNotNil ];
			onMouseProcessor.

		aStep check
			label: 'Check last click event is ClickEvent';
			satisfies: [ :aMouseProcessor |
				aMouseProcessor lastClickEvent isKindOf: BlClickEvent ];
			onMouseProcessor.

		aStep check
			label: 'Check last click event has correct target';
			satisfies: [ :aMouseProcessor |
				aMouseProcessor lastClickEvent target = scripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check element was clicked';
			satisfies: [ :anElement | anElement clickCount = 1 ];
			onSelf ].

	scripter syncPlay
]

{ #category : #tests }
BlMouseProcessorClickTest >> testMouseDown [

	scripter substeps: 'Click' do: [ :aStep |
		aStep mouseMove by: 70 @ 60. "enter"
		aStep mouseDown.

		aStep check
			label: 'Check previous mouse down event';
			value: [ :aMouseProcessor |
				aMouseProcessor lastMouseDownEvent target ]
			equals: [ scripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
			equals: [ scripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: [
				{
					scripter element.
					scripter root } ];
			onMouseProcessor ].

	scripter syncPlay
]

{ #category : #tests }
BlMouseProcessorClickTest >> testMouseEnter [

	scripter substeps: 'Mouse Enter' do: [ :aStep |
		aStep mouseMove by: 30 @ 30. "outside"
		aStep mouseMove by: 70 @ 60. "inside"

		aStep check
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
			equals: [ scripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: [
				{
					scripter element.
					scripter root } ];
			onMouseProcessor ].

	scripter syncPlay
]
