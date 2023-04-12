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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
	| aString |
	aString := String cr.
	self assert: (aString allSatisfy: #isLineBreak).
	self assert: aString size equals: 1.
	^ aString
]

{ #category : #tests }
BlTextOperatorTest >> testSeparators [

	<gtExample>
	| aString |
	aString := String space , String tab , String cr.
	self assert: (aString allSatisfy: #isSeparator).
	self assert: aString size equals: 3.
	^ aString
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithLineBreaksInTheMiddle [

	<gtExample>
	^ 'the first text' , self testLineBreaks , 'the second text'
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithLineBreaksOnBothSidesAndInTheMiddle [

	<gtExample>
	^ self testLineBreaks , self testStringWithLineBreaksInTheMiddle
	  , self testLineBreaks
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithSeparatorsInTheMiddle [

	<gtExample>
	^ 'the first text' , self testSeparators , 'the second text'
]

{ #category : #tests }
BlTextOperatorTest >> testStringWithSeparatorsOnBothSidesAndInTheMiddle [

	<gtExample>
	^ self testSeparators , self testStringWithSeparatorsInTheMiddle
	  , self testSeparators
]

{ #category : #tests }
BlTextOperatorTest >> testTrimBothTextWithLineBreakssOnBothSidesAndInTheMiddle [

	<gtExample>
	| aText |
	aText := self testStringWithLineBreaksOnBothSidesAndInTheMiddle asRopedText.
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

	<gtExample>
	| aText |
	aText := self testStringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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

	<gtExample>
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
