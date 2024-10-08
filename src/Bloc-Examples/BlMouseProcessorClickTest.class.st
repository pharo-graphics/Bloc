Class {
	#name : #BlMouseProcessorClickTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Event-Scripter'
}

{ #category : #running }
BlMouseProcessorClickTest >> newScripterElement [

	^ BlEventCountingElement new
		  size: 100 @ 75;
		  position: 50 @ 50;
		  yourself
]

{ #category : #tests }
BlMouseProcessorClickTest >> testClick [

	| aScripter |
	aScripter := self testMouseEnter.

	aScripter substeps: 'Click' do: [ :aStep |
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
				aMouseProcessor lastClickEvent target = aScripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check element was clicked';
			satisfies: [ :anElement | anElement clickCount = 1 ];
			onSelf ].
	aScripter syncContinue.

	^ aScripter
]

{ #category : #tests }
BlMouseProcessorClickTest >> testMouseDown [

	| aScripter |
	aScripter := self testMouseEnter.

	aScripter substeps: 'Click' do: [ :aStep |
		aStep mouseDown.

		aStep check
			label: 'Check previous mouse down event';
			value: [ :aMouseProcessor |
				aMouseProcessor lastMouseDownEvent target ]
			equals: [ aScripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
			equals: [ aScripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: [
				{
					aScripter element.
					aScripter root } ];
			onMouseProcessor ].

	^ aScripter syncContinue
]

{ #category : #tests }
BlMouseProcessorClickTest >> testMouseEnter [

	| aScripter |
	aScripter := BlDevScripter new.
	aScripter element: self newScripterElement.

	aScripter substeps: 'Mouse Enter' do: [ :aStep |
		aStep mouseMove by: 30 @ 30.

		aStep mouseMove by: 70 @ 60.

		aStep check
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ]
			equals: [ aScripter element ];
			onMouseProcessor.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: [
				{
					aScripter element.
					aScripter root } ];
			onMouseProcessor ].

	aScripter syncContinue.

	^ aScripter
]
