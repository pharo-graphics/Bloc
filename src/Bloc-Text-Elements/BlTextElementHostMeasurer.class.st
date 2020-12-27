Class {
	#name : #BlTextElementHostMeasurer,
	#superclass : #BlTextElementMeasurer,
	#category : #'Bloc-Text-Elements'
}

{ #category : #'host space - rendering' }
BlTextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [
	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space
				measureTextParagraph: aBlTextParagraph
				ifNotAvailable: [  ] ]
		ifFalse: [  ]
]
