Class {
	#name : #BATextMeasurerTest,
	#superclass : #BlTextParagraphExamplesTest,
	#category : #'Bloc-Alexandrie-Tests'
}

{ #category : #'instance creation' }
BATextMeasurerTest >> realMeasurer [

	^ BAOffscreen instance textMeasurer
]

{ #category : #'geometry - 100@100.' }
BATextMeasurerTest >> testIndexAtBetweenAllCharactersInRealPointWithDot [

	| aParagraph theIndices |
	aParagraph := self newParagraph.
	aParagraph text: self pointWithDotText.
	aParagraph measureOn: self realMeasurer.

	theIndices :=
		(0 to: aParagraph text size)
			collect: [ :anIndex |
				| aPoint |
				aPoint := aParagraph positionAt: anIndex.
				aParagraph indexAtPosition: aPoint floor ].

	self assert: theIndices equals: (0 to: aParagraph text size) asArray
]

{ #category : #'geometry - tab tab' }
BATextMeasurerTest >> testIndexAtBetweenAllCharactersInRealTabTab [

	| aParagraph theIndices |
	aParagraph := self newParagraph.
	aParagraph text: (String tab, String tab) asRopedText.
	aParagraph measureOn: self realMeasurer.

	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		              | aPoint |
		              aPoint := aParagraph positionAt: anIndex.
		              aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: #(0 2 2)
]

{ #category : #'geometry - HelloWorld' }
BATextMeasurerTest >> testIndexAtBetweenFirstAndSecondCharacterInRealHelloWorld [

	| aParagraph anIndex aPosition |
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self realMeasurer.

	aPosition := aParagraph positionAt: 1.
	anIndex := aParagraph indexAtPosition: aPosition.

	self assert: anIndex equals: 1
]

{ #category : #'geometry - HelloWorld' }
BATextMeasurerTest >> testIndexAtBetweenSeventhAndEighthCharacterInRealHelloWorld [

	| aParagraph anIndex aPosition |
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self realMeasurer.

	aPosition := aParagraph positionAt: 7.
	anIndex := aParagraph indexAtPosition: aPosition.

	self assert: anIndex equals: 7
]

{ #category : #'paragraph - measuring' }
BATextMeasurerTest >> testRealMeasuredHelloWorld [

	| aParagraph aLine aFirstSpan aSecondSpan aText aHello aWorld |
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self realMeasurer.

	aText := aParagraph text.
	aHello := aText from: 1 to: 5.
	aWorld := aText from: 6 to: 10.

	self assert: aParagraph measuredEnd equals: aText size.

	aLine := aParagraph line.
	self assert: aLine from equals: 1.
	self assert: aLine spans size equals: 2.
	self assert: aLine to equals: aText size.

	"first span"
	aFirstSpan := aLine spans first.
	self assert: aFirstSpan from equals: 1.
	self assert: aFirstSpan to equals: aHello size.
	self assert: aFirstSpan spanEnd equals: aHello size.
	self assert: aFirstSpan spanStart equals: 1.
	self assert: aFirstSpan spanLength equals: aHello size.
"	self assert: aFirstSpan textRunEnd equals: aHello size.
	self assert: aFirstSpan textRunStart equals: 1.
	self assert: aFirstSpan textRunLength equals: aHello size.
	self assert: aFirstSpan isSplitted not."

	"second span"
	aSecondSpan := aLine spans second.
	self assert: aSecondSpan from equals: aHello size + 1.
	self assert: aSecondSpan to equals: aHello size + aWorld size.
	self assert: aSecondSpan spanEnd equals: aWorld size.
	self assert: aSecondSpan spanStart equals: 1.
	self assert: aSecondSpan spanLength equals: aWorld size.
"	self assert: aSecondSpan textRunEnd equals: aWorld size.
	self assert: aSecondSpan textRunStart equals: 1.
	self assert: aSecondSpan textRunLength equals: aWorld size.
	self assert: aSecondSpan isSplitted not"
]
