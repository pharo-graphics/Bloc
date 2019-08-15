Class {
	#name : #BlAlternativeCombinationExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithA [
	<gtExample>
	| aCombination |
	
	aCombination := self emptyCombination.
	aCombination key: BlKeyboardKey a.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a }.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithAB [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithA.
	aCombination key: BlKeyboardKey b.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b }.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithABC [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithAB.	
	aCombination key: BlKeyboardKey c.

	self assert: (aCombination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b. BlKeyboardKey c }.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> emptyCombination [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination new.

	self assert: aCombination isAlternative.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.
 
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithA [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithA.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	self assert: (aCombination match: aBuffer) equals: 1.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithAB [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithAB.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: false key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithA [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithA.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	self assert: (aCombination match: aBuffer) equals: 0.
	
	^ aCombination
]

{ #category : #'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithAB [
	<gtExample>
	| aCombination aBuffer |
	
	aCombination := self combinationWithAB.
	
	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: BlKeyboardKey a.
	aBuffer pressed: true key: BlKeyboardKey b.
	aBuffer pressed: false key: BlKeyboardKey c.
	
	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 0.
	
	^ aCombination
]
