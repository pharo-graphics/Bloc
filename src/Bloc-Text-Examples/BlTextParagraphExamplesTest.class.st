"
I contain examples of a text paragraph

"
Class {
	#name : #BlTextParagraphExamplesTest,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Measurement'
}

{ #category : #'font - metrics' }
BlTextParagraphExamplesTest >> ascent [

	^ -10
]

{ #category : #'font - metrics' }
BlTextParagraphExamplesTest >> descent [

	^ 5
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> emoji [

	^ '😃'
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> emojiParagraph [

	| aParagraph |
	aParagraph := self newParagraph.
	aParagraph text: self emoji asRopedText.

	^ aParagraph
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> emptyParagraph [

	| aParagraph |
	aParagraph := self newParagraph.
	aParagraph text: BlText empty.

	^ aParagraph
]

{ #category : #'font - metrics' }
BlTextParagraphExamplesTest >> glyphWidth [

	^ 10
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> haba [

	^ 'Haba'
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> habaParagraph [

	<sampleInstance>
	| aParagraph |
	aParagraph := self newParagraph.
	aParagraph text: self haba asRopedText.

	^ aParagraph
]

{ #category : #'font - metrics' }
BlTextParagraphExamplesTest >> height [

	^ 12
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> helloWorldParagraph [

	<sampleInstance>
	| aParagraph |
	aParagraph := self newParagraph.
	aParagraph text: self helloWorldText.

	^ aParagraph
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> helloWorldText [

	<sampleInstance>
	| aText |
	aText := 'HelloWorld' asRopedText.
	(aText from: 1 to: 5) foreground: Color red.

	^ aText
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> newParagraph [

	^ BlTextParagraph new
		baselineMeasurer: BlAscentTightBaselineMeasurer uniqueInstance;
		yourself
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> objectPrintOnText [

	<sampleInstance>
	| aText |
	aText := 'Object>>#printOn:' asRopedText.
	(aText from: 1 to: 6) foreground: Color blue.
	(aText from: 9 to: aText size) foreground: Color magenta.

	^ aText
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> pointWithDotText [

	<sampleInstance>
	| aText |
	aText := '100@100.' asRopedText.
	(aText from: 1 to: 3) foreground: Color red.
	(aText from: 5 to: 7) foreground: Color red.
	(aText from: 8 to: 8) bold.

	^ aText
]

{ #category : #'geometry - HelloWorld' }
BlTextParagraphExamplesTest >> testIndexAtBetweenAllCharacterInHelloWorld [

	<sampleInstance>
	| aParagraph theIndices |
	aParagraph := self testMeasuredHelloWorld.

	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		              aParagraph indexAtPosition:
			              self glyphWidth * anIndex @ self ascent ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlTextParagraphExamplesTest >> testIndexAtBetweenAllCharactersInObjectPrintOn [

	<sampleInstance>
	| aParagraph theIndices |
	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self testMeasurer.

	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		              aParagraph indexAtPosition:
			              self glyphWidth * anIndex @ self ascent ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ theIndices
]

{ #category : #'geometry - 100@100.' }
BlTextParagraphExamplesTest >> testIndexAtBetweenAllCharactersInPointWithDot [

	| aParagraph theIndices |
	aParagraph := self newParagraph.
	aParagraph text: self pointWithDotText.
	aParagraph measureOn: self testMeasurer.

	theIndices :=
		(0 to: aParagraph text size)
			collect: [ :anIndex |
				| aPoint |
				aPoint := aParagraph positionAt: anIndex.
				aParagraph indexAtPosition: aPoint ].

	self assert: theIndices equals: (0 to: aParagraph text size) asArray
]

{ #category : #'geometry - tab tab' }
BlTextParagraphExamplesTest >> testIndexAtBetweenAllCharactersInTabTab [

	<sampleInstance>
	| aParagraph theIndices |
	aParagraph := self newParagraph.
	aParagraph text: (String tab , String tab) asRopedText.
	aParagraph measureOn: self testMeasurer.

	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		              | aPoint |
		              aPoint := aParagraph positionAt: anIndex.
		              aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtBetweenFirstAndSecondCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition: self glyphWidth @ self ascent.

	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlTextParagraphExamplesTest >> testIndexAtBetweenFirstAndSecondCharacterInHelloWorld [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHelloWorld.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 1 @ self ascent.

	self assert: anIndex equals: 1.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlTextParagraphExamplesTest >> testIndexAtBetweenFirstAndSecondCharacterInObjectPrintOn [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self testMeasurer.

	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 1 @ self ascent.

	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtBetweenHalfsOfFirstCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth / 2.0 @ self ascent.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlTextParagraphExamplesTest >> testIndexAtBetweenSeventhAndEighthCharacterInHelloWorld [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHelloWorld.

	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 7 @ self ascent.

	self assert: anIndex equals: 7.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlTextParagraphExamplesTest >> testIndexAtBetweenSeventhAndEighthCharacterInObjectPrintOn [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self testMeasurer.

	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 7 @ self ascent.

	self assert: anIndex equals: 7.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarBottomLeftPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition:
		           (self ascent * 10) negated @ (self ascent * 10).

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtFarBottomLeftPointInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           (self glyphWidth * self haba size * 10) negated
		           @ (self ascent * 10).

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarBottomPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ (self ascent * 10).

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarBottomRightPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition:
		           self ascent * 10 @ (self ascent * 10).

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarTopLeftPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition:
		           (self ascent * 10) asPoint negated.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarTopPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ (self ascent * 10) negated.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarTopRightPointInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition:
		           self ascent * 10 @ (self ascent * 10) negated.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testIndexAtFarZeroInEmpty [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ 0.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtLeftHalfOfFirstCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth / 3.0 @ self ascent.

	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtLeftHalfOfForthCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 3 + (self glyphWidth / 3.0)
		           @ self ascent.

	self assert: anIndex equals: 3.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtLeftHalfOfSecondCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 1 + (self glyphWidth / 3.0)
		           @ self ascent.

	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtLeftHalfOfThirdCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth * 2 + (self glyphWidth / 3.0)
		           @ self ascent.

	self assert: anIndex equals: 2.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlTextParagraphExamplesTest >> testIndexAtRightHalfOfFirstCharacterInHaba [

	<sampleInstance>
	| aParagraph anIndex |
	aParagraph := self testMeasuredHaba.
	anIndex := aParagraph indexAtPosition:
		           self glyphWidth / 1.5 @ self ascent.

	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'paragraph - measuring' }
BlTextParagraphExamplesTest >> testMeasuredEmoji [

	<sampleInstance>
	| aParagraph aLine aSpan |
	aParagraph := self emojiParagraph.
	aParagraph measureOn: self testMeasurer.

	self assert: aParagraph measuredEnd equals: 1.

	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 1.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: self emoji size * self glyphWidth.

	aSpan := aLine spans first.
	self assert: aSpan advance equals: self emoji size * self glyphWidth.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 1.
	self assert: aSpan height equals: self height.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 1.
	self assert: aSpan spanStart equals: 1.
	self assert: aSpan textRun equals: self emoji.
	self assert: aSpan textRunEnd equals: 1.
	self assert: aSpan textRunStart equals: 1.
	self assert: aSpan to equals: 1.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: self emoji size * self glyphWidth.

	self assert: aSpan spanLength equals: 1.
	self assert: aSpan textRunLength equals: 1.
	self assert: aSpan isSplitted not.

	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlTextParagraphExamplesTest >> testMeasuredEmpty [

	<sampleInstance>
	| aParagraph aLine aSpan |
	aParagraph := self emptyParagraph.
	aParagraph measureOn: self testMeasurer.

	self assert: aParagraph measuredEnd equals: 0.

	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 0.
	self assert: aLine height equals: 0.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 0.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: 0.

	aSpan := aLine spans first.
	self assert: aSpan advance equals: 0.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 0.
	self assert: aSpan height equals: 0.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 0.
	self assert: aSpan spanStart equals: 0.
	self assert: aSpan textRun equals: ''.
	self assert: aSpan textRunEnd equals: 0.
	self assert: aSpan textRunStart equals: 0.
	self assert: aSpan to equals: 0.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: 0.

	self assert: aSpan spanLength equals: 0.
	self assert: aSpan textRunLength equals: 0.
	self assert: aSpan isSplitted not.

	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlTextParagraphExamplesTest >> testMeasuredHaba [

	<sampleInstance>
	| aParagraph aLine aSpan |
	aParagraph := self habaParagraph.
	aParagraph measureOn: self testMeasurer.

	"self assert: aParagraph measuredEnd equals: 4."

	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 4.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: self haba size * self glyphWidth.

	aSpan := aLine spans first.
	self assert: aSpan advance equals: self haba size * self glyphWidth.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 1.
	self assert: aSpan height equals: self height.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 4.
	self assert: aSpan spanStart equals: 1.
	self assert: aSpan to equals: 4.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: self haba size * self glyphWidth.
	self assert: aSpan spanLength equals: 4.

"	self assert: aSpan textRun equals: self haba.
	self assert: aSpan textRunEnd equals: 4.
	self assert: aSpan textRunStart equals: 1.
	self assert: aSpan textRunLength equals: 4.
	self assert: aSpan isSplitted not."

	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlTextParagraphExamplesTest >> testMeasuredHelloWorld [

	<sampleInstance>
	| aParagraph aLine aFirstSpan aSecondSpan aText aHello aWorld |
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self testMeasurer.

	aText := aParagraph text.
	aHello := aText from: 1 to: 5.
	aWorld := aText from: 6 to: 10.

	self assert: aParagraph measuredEnd equals: aText size.

	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 2.
	self assert: aLine to equals: aText size.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: aText size * self glyphWidth.

	"first span"
	aFirstSpan := aLine spans first.
	self assert: aFirstSpan advance equals: aHello size * self glyphWidth.
	self assert: aFirstSpan ascent equals: self ascent.
	self assert: aFirstSpan baseline equals: 0 @ self ascent abs.
	self assert: aFirstSpan descent equals: self descent.
	self assert: aFirstSpan from equals: 1.
	self assert: aFirstSpan to equals: aHello size.
	self assert: aFirstSpan height equals: self height.
	self assert: aFirstSpan left equals: 0.
	self assert: aFirstSpan spanEnd equals: aHello size.
	self assert: aFirstSpan spanStart equals: 1.
	self assert: aFirstSpan textRun equals: aHello asString.
	self assert: aFirstSpan textRunEnd equals: aHello size.
	self assert: aFirstSpan textRunStart equals: 1.
	self assert: aFirstSpan top equals: 0.
	self assert: aFirstSpan width equals: aHello size * self glyphWidth.
	self assert: aFirstSpan spanLength equals: aHello size.
	self assert: aFirstSpan textRunLength equals: aHello size.
	self assert: aFirstSpan isSplitted not.

	"second span"
	aSecondSpan := aLine spans second.
	self
		assert: aSecondSpan advance
		equals: aWorld size * self glyphWidth.
	self assert: aSecondSpan ascent equals: self ascent.
	self
		assert: aSecondSpan baseline
		equals: aFirstSpan width @ self ascent abs.
	self assert: aSecondSpan descent equals: self descent.
	self assert: aSecondSpan from equals: aHello size + 1.
	self assert: aSecondSpan to equals: aHello size + aWorld size.
	self assert: aSecondSpan height equals: self height.
	self assert: aSecondSpan left equals: 0.
	self assert: aSecondSpan spanEnd equals: aWorld size.
	self assert: aSecondSpan spanStart equals: 1.
	self assert: aSecondSpan textRun equals: aWorld asString.
	self assert: aSecondSpan textRunEnd equals: aWorld size.
	self assert: aSecondSpan textRunStart equals: 1.
	self assert: aSecondSpan top equals: 0.
	self assert: aSecondSpan width equals: aWorld size * self glyphWidth.
	self assert: aSecondSpan spanLength equals: aWorld size.
	self assert: aSecondSpan textRunLength equals: aWorld size.
	self assert: aSecondSpan isSplitted not.

	^ aParagraph
]

{ #category : #'instance creation' }
BlTextParagraphExamplesTest >> testMeasurer [

	<sampleInstance>
	| aMeasurer |
	aMeasurer := BAMockedTextMeasurer new
		             ascent: self ascent;
		             descent: self descent;
		             glyphWidth: self glyphWidth;
		             height: self height.

	self assert: aMeasurer ascent equals: self ascent.
	self assert: aMeasurer descent equals: self descent.
	self assert: aMeasurer glyphWidth equals: self glyphWidth.
	self assert: aMeasurer height equals: self height.

	^ aMeasurer
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testPositionAtIndexInEmpty [

	<sampleInstance>
	| aParagraph aPoint |
	aParagraph := self testMeasuredEmpty.
	aPoint := aParagraph positionAt: 0.

	self assert: aPoint equals: 0 @ aParagraph baseline y.

	^ aPoint
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarBottomLeftPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint:
		         (self ascent * 10) negated @ (self ascent * 10).

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarBottomPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint: 0 @ (self ascent * 10).

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarBottomRightPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint:
		         self ascent * 10 @ (self ascent * 10).

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarTopLeftPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) asPoint negated.

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarTopPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint: 0 @ (self ascent * 10) negated.

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarTopRightPointInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint:
		         self ascent * 10 @ (self ascent * 10) negated.

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtFarZeroInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtPoint: 0 @ 0.

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]

{ #category : #'geometry - empty' }
BlTextParagraphExamplesTest >> testSpanAtIndexInEmpty [

	<sampleInstance>
	| aParagraph aSpan |
	aParagraph := self testMeasuredEmpty.
	aSpan := aParagraph spanAtIndex: 0.

	self assert: aSpan equals: aParagraph line spans first.

	^ aSpan
]
