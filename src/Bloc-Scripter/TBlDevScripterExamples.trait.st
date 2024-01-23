"
I provide useful API for classes that use `BlDevScripter`.
"
Trait {
	#name : #TBlDevScripterExamples,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter [

	^ BlDevScripter new
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock [

	^ self
		  scripter: aScripter
		  withModel: aModelBlock
		  element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripter: aScripter withModel: aModelBlock element: anElementBlock [

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

	^ self
		  scripter: self scripter
		  withModel: [ nil ]
		  element: anElementBlock
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock [

	^ self
		  scripter: self scripter
		  withModel: aModelBlock
		  element: [ :aModel | aModel asElement ]
]

{ #category : #'examples - scripter' }
TBlDevScripterExamples >> scripterWithModel: aModelBlock element: anElementBlock [

	^ self
		  scripter: self scripter
		  withModel: aModelBlock
		  element: anElementBlock
]
