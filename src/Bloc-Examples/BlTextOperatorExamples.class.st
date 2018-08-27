Class {
	#name : #BlTextOperatorExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'trimmer - line breaks' }
BlTextOperatorExamples >> lineBreaks [
	<gtExample>
	| aString |
	aString := String cr, String lf.
	self assert: (aString allSatisfy: #isLineBreak).
	self assert: aString size equals: 2.
	^ aString
]

{ #category : #trimmer }
BlTextOperatorExamples >> separators [
	<gtExample>
	| aString |
	aString := String space, String tab, String cr, String lf.
	self assert: (aString allSatisfy: #isSeparator).
	self assert: aString size equals: 4.
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
