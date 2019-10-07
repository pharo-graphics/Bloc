"
I exist to prevent opening of Morphic World when running with a headless vm and --interactive flag
"
Class {
	#name : #BlNullWorldRenderer,
	#superclass : #NullWorldRenderer,
	#category : #'BlocHost-Morphic-World'
}

{ #category : #accessing }
BlNullWorldRenderer class >> isApplicableFor: aWorld [
	^ Smalltalk isHeadless and: [ CommandLineArguments new hasOption: 'interactive'  ]
]

{ #category : #accessing }
BlNullWorldRenderer class >> priority [ 
	^ 20
]
