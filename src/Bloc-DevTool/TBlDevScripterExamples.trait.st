Trait {
	#name : #TBlDevScripterExamples,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter [
	<gtExample>
	| aScripter |
	aScripter := BlDevScripter new.
	
	self assert: aScripter events isEmpty.
	
	^ aScripter
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock [
	<gtExample>
	^ self 
		scripter: aScripter 
		withModel: aModelBlock 
		element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock element: anElementBlock [
	<gtExample>
	aScripter substep: 'Initialize Model and UI' do: [ :aStep | 
		aStep set 
			label: 'Initialize Model';
			model: aModelBlock.
		aStep set 
			label: 'Initialize UI';
			element: anElementBlock;
			onModel ].
		
	aScripter wait forEmptySpaceTaskQueue.
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock [
	<gtExample>
	^ self 
		scripter: self scripter 
		withModel: aModelBlock 
		element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithSpace: aSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter space: aSpace.
	
	self assert: aScripter space equals: aSpace.
	
	^ aScripter.
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithSpace: aSpace model: aModelBlock element: anElementBlock [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithSpace: aSpace.
	self scripter: aScripter withModel: aModelBlock element: anElementBlock.
	
	^ aScripter
]
