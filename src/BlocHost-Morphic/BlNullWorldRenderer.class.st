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

	| cla |

	(isEnabled isNotNil and: [ isEnabled not ])
		ifTrue: [ ^ false ].

	cla := CommandLineArguments new.
	^ Smalltalk isHeadless 
		and: [ (cla hasOption: 'interactive')
		and: [ (cla hasOption: 'morphic') not ] ]
]

{ #category : #accessing }
BlNullWorldRenderer class >> priority [ 
	^ 20
]
