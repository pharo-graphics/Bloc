"
I have been automatically converted and probably manually tweaked from BlTextOperatorExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlTextOperatorTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Tests'
}

{ #category : #tests }
BlTextOperatorTest >> testFindCaseInsensitiveSubStringInTheMiddle [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "STRING" substring' asRopedText.
	anIndex := aText finder
		           caseInsensitiveSubstring: '"string"';
		           search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $".
	(aText from: anIndex to: anIndex + 7) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindGCharacterInAMiddle [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for G character' asRopedText.
	anIndex := aText finder
		           character: $G;
		           search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $G.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindGCharacterInAMiddleReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for G character' asRopedText.
	anIndex := aText finder
		           startAtEnd;
		           reversed;
		           character: $G;
		           search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $G.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindIngSubStringInTheMiddle [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "ing" substring' asRopedText.
	anIndex := aText finder
		           substring: 'ing';
		           search.
	self assert: anIndex equals: 5.
	self assert: (aText at: 5) equals: $i.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindIngSubStringInTheMiddleReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "ing" substring' asRopedText.
	anIndex := aText finder
		           reversed;
		           startAtEnd;
		           substring: '"ing"';
		           search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $".
	(aText from: anIndex to: anIndex + 4) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindLCharacterAtTheBeginning [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for L character' asRopedText.
	anIndex := aText finder
		           character: $L;
		           search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindLCharacterAtTheBeginningReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for l character' asRopedText.
	anIndex := aText finder
		           startAtEnd;
		           reversed;
		           character: $L;
		           search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindLookSubStringInTheBeginning [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "ling" substring' asRopedText.
	anIndex := aText finder
		           substring: 'Look';
		           search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindLookSubStringInTheBeginningReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "ling" substring' asRopedText.
	anIndex := aText finder
		           startAtEnd;
		           reversed;
		           substring: 'Look';
		           search.
	self assert: anIndex equals: 1.
	self assert: (aText at: 1) equals: $L.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindNoSubString [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for not existing substring' asRopedText.
	anIndex := aText finder
		           substring: 'something';
		           search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindNoSubStringReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for not existing substring' asRopedText.
	anIndex := aText finder
		           reversed;
		           startAtEnd;
		           substring: 'something';
		           search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindNothing [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for not included character' asRopedText.
	anIndex := aText finder
		           character: $Z;
		           search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindRCharacterAtTheEnd [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for r characteR' asRopedText.
	anIndex := aText finder
		           character: $R;
		           search.
	self assert: anIndex equals: 23.
	self assert: (aText at: 23) equals: $R.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindRCharacterAtTheEndReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for r characteR' asRopedText.
	anIndex := aText finder
		           startAtEnd;
		           reversed;
		           character: $R;
		           search.
	self assert: anIndex equals: 23.
	self assert: (aText at: 23) equals: $R.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindRingSubStringInTheEnd [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "Ring" substring' asRopedText.
	anIndex := aText finder
		           substring: 'ring';
		           search.
	self assert: anIndex equals: 25.
	self assert: (aText at: 25) equals: $r.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindRingSubStringInTheEndReversed [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for "Ring" substring' asRopedText.
	anIndex := aText finder
		           startAtEnd;
		           reversed;
		           substring: 'ring';
		           search.
	self assert: anIndex equals: 25.
	self assert: (aText at: 25) equals: $r.
	(aText from: anIndex to: anIndex + 3) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testFindxXCharactersAtTheBeginning [

	<sampleInstance>
	| aText anIndex |
	aText := 'Looking for X character' asRopedText.
	anIndex := aText finder
		           characters: 'xX';
		           search.
	self assert: anIndex equals: 13.
	self assert: (aText at: 13) equals: $X.
	(aText from: anIndex to: anIndex) foreground: Color red.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testLineBreaks [

	<sampleInstance>
	| aString |
	aString := String cr.
	self assert: (aString allSatisfy: #isLineBreak).
	self assert: aString size equals: 1.
	^ aString
]

{ #category : #tests }
BlTextOperatorTest >> testSeparators [

	<sampleInstance>
	| aString |
	aString := String space , String tab , String cr.
	self assert: (aString allSatisfy: #isSeparator).
	self assert: aString size equals: 3.
	^ aString
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithLineBreaksInTheMiddle [

	<sampleInstance>
	^ 'the first text' , self testLineBreaks , 'the second text'
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithLineBreaksOnBothSidesAndInTheMiddle [

	<sampleInstance>
	^ self testLineBreaks , self testStringWithLineBreaksInTheMiddle
	  , self testLineBreaks
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithSeparatorsInTheMiddle [

	<sampleInstance>
	^ 'the first text' , self testSeparators , 'the second text'
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithSeparatorsOnBothSidesAndInTheMiddle [

	<sampleInstance>
	^ self testSeparators , self testStringWithSeparatorsInTheMiddle
	  , self testSeparators
]

{ #category : #tests }
BlTextOperatorTest >> testTrimBothTextWithLineBreakssOnBothSidesAndInTheMiddle [

	<sampleInstance>
	| aText |
	aText := self testStringWithLineBreaksOnBothSidesAndInTheMiddle
		         asRopedText.
	aText trimmer
		bothLineBreaks;
		trim.
	self
		assert: aText size
		equals: self testStringWithLineBreaksOnBothSidesAndInTheMiddle size
			- (self testLineBreaks size * 2).
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testTrimBothTextWithSeparatorsOnBothSidesAndInTheMiddle [

	<sampleInstance>
	| aText |
	aText := self testStringWithSeparatorsOnBothSidesAndInTheMiddle
		         asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self
		assert: aText size
		equals: self testStringWithSeparatorsOnBothSidesAndInTheMiddle size
			- (self testSeparators size * 2).
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testTrimEmptyText [

	<sampleInstance>
	| aText |
	aText := '' asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self assert: aText size equals: 0.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testTrimLeftTextWithSeparatorsOnBothSidesAndInTheMiddle [

	<sampleInstance>
	| aText |
	aText := self testStringWithSeparatorsOnBothSidesAndInTheMiddle
		         asRopedText.
	aText trimmer
		leftSeparators;
		trim.
	self
		assert: aText size
		equals: self testStringWithSeparatorsOnBothSidesAndInTheMiddle size
			- self testSeparators size.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testTrimOnlySeparatorsText [

	<sampleInstance>
	| aText |
	aText := self testSeparators asRopedText.
	aText trimmer
		bothSeparators;
		trim.
	self assert: aText size equals: 0.
	^ aText
]

{ #category : #tests }
BlTextOperatorTest >> testTrimRightTextWithSeparatorsOnBothSidesAndInTheMiddle [

	<sampleInstance>
	| aText |
	aText := self testStringWithSeparatorsOnBothSidesAndInTheMiddle
		         asRopedText.
	aText trimmer
		rightSeparators;
		trim.
	self
		assert: aText size
		equals: self testStringWithSeparatorsOnBothSidesAndInTheMiddle size
			- self testSeparators size.
	^ aText
]
