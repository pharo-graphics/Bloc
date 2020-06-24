Class {
	#name : #BlMouseProcessorDragExamples,
	#superclass : #BlMouseProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseDown [
	<gtExample>
	| aScripter |
	
	aScripter := self mouseEnter.
	
	aScripter substeps: 'Mouse down' do: [ :aStep |			
		aStep mouseDown ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseEnter [
	<gtExample>
	| aScripter |
	
	aScripter := self scripter.
	aScripter element: self scripterElement.
	
	aScripter substeps: 'Mouse Enter' do: [ :aStep |			
		aStep mouseMove
			delta: 30@30.

		aStep mouseMove
			delta: 50@60 ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseMove [
	<gtExample>
	| aScripter |
	
	aScripter := self mouseDown.
	
	aScripter substeps: 'Mouse move' do: [ :aStep |			
		aStep mouseMove
			delta: 60@10.
		
		aStep check
			label: 'Check element was dragged';
			satisfies: [ :anElement | anElement position = (110.0@60.0) ];
			onSelf ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseUp [
	<gtExample>
	| aScripter |
	
	aScripter := self mouseMove.
	
	aScripter substeps: 'Mouse up' do: [ :aStep |			
		aStep mouseUp.
		
		aStep check
			label: 'Check element was dragged';
			satisfies: [ :anElement | anElement position = (110.0@60.0) ];
			onSelf ].
	
	^ aScripter syncContinue
]
