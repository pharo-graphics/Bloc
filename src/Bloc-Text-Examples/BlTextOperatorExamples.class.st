Class {
	#name : #BlTextOperatorExamples,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'finder - case insensitive substring' }
BlTextOperatorExamples >> findCaseInsensitiveSubStringInTheMiddle [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findGCharacterInAMiddle [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findGCharacterInAMiddleReversed [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findIngSubStringInTheMiddle [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findIngSubStringInTheMiddleReversed [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findLCharacterAtTheBeginning [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findLCharacterAtTheBeginningReversed [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findLookSubStringInTheBeginning [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findLookSubStringInTheBeginningReversed [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findNoSubString [
	<gtExample>
	| aText anIndex |
	aText := 'Looking for not existing substring' asRopedText.
	anIndex := aText finder
		substring: 'something';
		search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findNoSubStringReversed [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findNothing [
	<gtExample>
	| aText anIndex |
	aText := 'Looking for not included character' asRopedText.
	anIndex := aText finder
		character: $Z;
		search.
	self assert: anIndex equals: 0.
	^ aText
]

{ #category : #'finder - character' }
BlTextOperatorExamples >> findRCharacterAtTheEnd [
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

{ #category : #'finder - character' }
BlTextOperatorExamples >> findRCharacterAtTheEndReversed [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findRingSubStringInTheEnd [
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

{ #category : #'finder - substring' }
BlTextOperatorExamples >> findRingSubStringInTheEndReversed [
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

{ #category : #'finder - characters' }
BlTextOperatorExamples >> findxXCharactersAtTheBeginning [
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

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> lineBreaks [
	<gtExample>
	| aString |
	aString := String cr.
	self assert: (aString allSatisfy: #isLineBreak).
	self assert: aString size equals: 1.
	^ aString
]

{ #category : #trimmer }
BlTextOperatorExamples >> separators [
	<gtExample>
	| aString |
	aString := String space, String tab, String cr.
	self assert: (aString allSatisfy: #isSeparator).
	self assert: aString size equals: 3.
	^ aString
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> stringWithLineBreaksInTheMiddle [
	<gtExample>
	^ 'the first text', self lineBreaks, 'the second text'
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> stringWithLineBreaksOnBothSidesAndInTheMiddle [
	<gtExample>
	^ self lineBreaks, self stringWithLineBreaksInTheMiddle, self lineBreaks
]

{ #category : #trimmer }
BlTextOperatorExamples >> stringWithSeparatorsInTheMiddle [
	<gtExample>
	^ 'the first text', self separators, 'the second text'
]

{ #category : #trimmer }
BlTextOperatorExamples >> stringWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	^ self separators, self stringWithSeparatorsInTheMiddle, self separators
]

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> trimBothTextWithLineBreakssOnBothSidesAndInTheMiddle [
	<gtExample>
	| aText |
	aText := self stringWithLineBreaksOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer bothLineBreaks; trim.
	self 
		assert: aText size 
		equals: self stringWithLineBreaksOnBothSidesAndInTheMiddle size - (self lineBreaks size * 2).
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimBothTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer bothSeparators; trim.
	self 
		assert: aText size 
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size - (self separators size * 2).
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimEmptyText [
	<gtExample>
	| aText |
	aText := '' asRopedText.
	aText trimmer bothSeparators; trim.
	self 
		assert: aText size 
		equals: 0.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimLeftTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer leftSeparators; trim.
	self 
		assert: aText size 
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size - self separators size.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimOnlySeparatorsText [
	<gtExample>
	| aText |
	aText := self separators asRopedText.
	aText trimmer bothSeparators; trim.
	self 
		assert: aText size 
		equals: 0.
	^ aText
]

{ #category : #trimmer }
BlTextOperatorExamples >> trimRightTextWithSeparatorsOnBothSidesAndInTheMiddle [
	<gtExample>
	| aText |
	aText := self stringWithSeparatorsOnBothSidesAndInTheMiddle asRopedText.
	aText trimmer rightSeparators; trim.
	self 
		assert: aText size 
		equals: self stringWithSeparatorsOnBothSidesAndInTheMiddle size - self separators size.
	^ aText
]
