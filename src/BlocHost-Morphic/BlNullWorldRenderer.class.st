"
I exist to prevent opening of Morphic World when running with a headless vm and --interactive flag
"
Class {
	#name : #BlNullWorldRenderer,
	#superclass : #NullWorldRenderer,
	#classVars : [
		'isEnabled'
	],
	#category : #'BlocHost-Morphic-World'
}

{ #category : #protocol }
BlNullWorldRenderer class >> disable [
	isEnabled := false
]

{ #category : #protocol }
BlNullWorldRenderer class >> enable [
	isEnabled := true
]

{ #category : #accessing }
BlNullWorldRenderer class >> initialize [
	isEnabled := true
]

{ #category : #accessing }
BlNullWorldRenderer class >> isApplicableFor: aWorld [
	<return: #Boolean>
	(isEnabled isNotNil and: [ isEnabled not ])
		ifTrue: [ ^ false ].

	^ Smalltalk isHeadless and: [ CommandLineArguments new hasOption: 'interactive'  ]
]

{ #category : #accessing }
BlNullWorldRenderer class >> priority [ 
	^ 20
]
