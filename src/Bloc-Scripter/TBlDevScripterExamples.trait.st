Trait {
	#name : #TBlDevScripterExamples,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter [

	<sampleInstance>
	| aScripter |
	aScripter := BlDevScripter new.

	self assert: aScripter events isEmpty.

	^ aScripter
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock [

	<sampleInstance>
	^ self
		  scripter: aScripter
		  withModel: aModelBlock
		  element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock element: anElementBlock [

	<sampleInstance>
	aScripter substep: 'Initialize Model and UI' do: [ :aStep |
		aStep set
			label: 'Initialize Model';
			model: aModelBlock.
		aStep set
			label: 'Initialize UI';
			element: anElementBlock;
			onModel.
		aStep wait forEmptySpaceTaskQueue ].
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithElement: anElementBlock [

	<sampleInstance>
	^ self
		  scripter: self scripter
		  withModel: [ nil ]
		  element: anElementBlock
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock [

	<sampleInstance>
	^ self
		  scripter: self scripter
		  withModel: aModelBlock
		  element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock element: anElementBlock [

	<sampleInstance>
	^ self
		  scripter: self scripter
		  withModel: aModelBlock
		  element: anElementBlock
]
