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
		
		"aStep check 
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
			onSelf" ].
	aScripter syncContinue.
	
	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorClickExamples >> mouseEnter [
	<gtExample>
	| aScripter |
	
	aScripter := self scripter.
	aScripter element: self scripterElement.
	
	aScripter substeps: 'Mouse Enter' do: [ :aStep |			
		aStep mouseMove
			delta: 30@30.

		aStep mouseMove
			delta: 70@60.
		
		"aStep check 
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
			onMouseProcessor."
			
		"aStep check 
			label: 'Check element was clicked';
			satisfies: [ :anElement | anElement clickCount = 1 ];
			onSelf" ].
	aScripter syncContinue.
	
	^ aScripter
]
