Class {
	#name : #BlTextElementHostMeasurer,
	#superclass : #BlTextElementMeasurer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlTextElementHostMeasurer class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
BlTextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space measureTextParagraph: aBlTextParagraph ]
		ifFalse: [
			BlHostRenderer preferableClass offscreenMeasureTextParagraph: aBlTextParagraph ]

]
