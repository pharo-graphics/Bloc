Class {
	#name : #BlMouseProcessorClickExamples,
	#superclass : #BlMouseProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> click [
	<gtExample>
	| aScripter |
	
	aScripter := self mouseEnter.
	
	aScripter substeps: 'Click' do: [ :aStep |			
		aStep mouseDown.
		aStep mouseUp.
		
		aStep check 
			label: 'Check last click event is not nil';
			satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent isNotNil ];
			onMouseProcessor.

		aStep check 
			label: 'Check last click event is ClickEvent';
			satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent isKindOf: BlClickEvent ];
			onMouseProcessor.
			
		aStep check 
			label: 'Check last click event has correct target';
			satisfies: [ :aMouseProcessor | aMouseProcessor lastClickEvent target = aScripter element ];
			onMouseProcessor.
			
		aStep check 
			label: 'Check element was clicked';
			satisfies: [ :anElement | anElement clickCount = 1 ];
			onSelf ].
	aScripter syncContinue.
	
	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> mouseDown [
	<gtExample>
	| aScripter |
	
	aScripter := self mouseEnter.
	
	aScripter substeps: 'Click' do: [ :aStep |			
		aStep mouseDown.
		
		aStep check 
			label: 'Check previous mouse down event';
			value: [ :aMouseProcessor | aMouseProcessor previousMouseDownEvent target ] equals: [ aScripter element ];
			onMouseProcessor.

		aStep check 
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ] equals: [ aScripter element ];
			onMouseProcessor.

		aStep check 
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ] equals: [ { aScripter element. aScripter root } ] ;
			onMouseProcessor ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> mouseEnter [
	<gtExample>
	| aScripter |
	
	aScripter := self scripter.
	aScripter element: self scripterElement.
	
	aScripter substeps: 'Mouse Enter' do: [ :aStep |			
		aStep mouseMove
			by: 30@30.

		aStep mouseMove
			by: 70@60.

		aStep check 
			label: 'Check last over target is the element';
			value: [ :aMouseProcessor | aMouseProcessor lastOverTarget ] equals: [ aScripter element ];
			onMouseProcessor.

		aStep check 
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ] equals: [ { aScripter element. aScripter root } ] ;
			onMouseProcessor ].

	aScripter syncContinue.
	
	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> scripterElement [
	<gtExample>
	
	^ BlExampleEventsCountingElement new
		size: 100@75;
		position: 50@50
]
