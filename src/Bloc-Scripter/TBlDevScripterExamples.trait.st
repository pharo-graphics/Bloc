Trait {
	#name : 'TBlDevScripterExamples',
	#category : 'Bloc-Scripter-Scripter',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter'
}

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripter [
	<gtExample>
	| aScripter |
	aScripter := BlDevScripter new.
	
	self assert: aScripter events isEmpty.
	
	^ aScripter
]

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock [
	<gtExample>
	^ self 
		scripter: aScripter 
		withModel: aModelBlock 
		element: [ :aModel | aModel asElement ]
]

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock element: anElementBlock [
	<gtExample>
	aScripter substep: 'Initialize Model and UI' do: [ :aStep | 
		aStep set 
			label: 'Initialize Model';
			model: aModelBlock.
		aStep set 
			label: 'Initialize UI';
			element: anElementBlock;
			onModel.
		aStep wait forEmptySpaceTaskQueue.		
	].
	^ aScripter syncContinue
]

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripterWithElement: anElementBlock [
	<gtExample>
	^ self 
		scripter: self scripter 
		withModel: [ nil ] 
		element: anElementBlock
]

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock [
	<gtExample>
	^ self 
		scripter: self scripter 
		withModel: aModelBlock 
		element: [ :aModel | aModel asElement ]
]

{ #category : 'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock element: anElementBlock [
	<gtExample>
	^ self 
		scripter: self scripter 
		withModel: aModelBlock 
		element: anElementBlock
]
