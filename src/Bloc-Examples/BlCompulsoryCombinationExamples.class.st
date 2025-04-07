Class {
	#name : #BlCompulsoryCombinationExamples,
	#superclass : #BlKeyCombinationExamplesTest,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> testCombinationWithA [

	<sampleInstance>
	| aCombination |
	aCombination := self testEmptyCombination.
	aCombination key: KeyboardKey A.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: { KeyboardKey A }.
	self assert: aCombination printString equals: '(A)'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> testCombinationWithAB [

	<sampleInstance>
	| aCombination |
	aCombination := self testCombinationWithA.
	aCombination key: KeyboardKey B.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {
				KeyboardKey A.
				KeyboardKey B }.
	self assert: aCombination printString equals: '(A & B)'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> testCombinationWithABC [

	<sampleInstance>
	| aCombination |
	aCombination := self testCombinationWithAB.
	aCombination key: KeyboardKey C.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {
				KeyboardKey A.
				KeyboardKey B.
				KeyboardKey C }.
	self assert: aCombination printString equals: '(A & B & C)'.

	^ aCombination
]

{ #category : #'examples - combination' }
BlCompulsoryCombinationExamples >> testEmptyCombination [

	<sampleInstance>
	| aCombination |
	aCombination := BlCompulsoryCombination new.

	self assert: aCombination isCompulsory.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.

	^ aCombination
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithA [

	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithA.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlCompulsoryCombination basicNew instVarAt: 1 put: ((OrderedCollection new) add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 65; instVarAt: 2 put: #A; yourself); yourself); yourself); yourself)'.

	aRestoredCombination := self class compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithAB [

	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithAB.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlCompulsoryCombination basicNew instVarAt: 1 put: ((OrderedCollection new) add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 65; instVarAt: 2 put: #A; yourself); yourself); add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 66; instVarAt: 2 put: #B; yourself); yourself); yourself); yourself)'.

	aRestoredCombination := self class compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithABC [

	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithABC.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlCompulsoryCombination basicNew instVarAt: 1 put: ((OrderedCollection new) add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 65; instVarAt: 2 put: #A; yourself); yourself); add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 66; instVarAt: 2 put: #B; yourself); yourself); add: (BlSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 67; instVarAt: 2 put: #C; yourself); yourself); yourself); yourself)'.

	aRestoredCombination := self class compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination
]

{ #category : #'examples - store' }
BlCompulsoryCombinationExamples >> testStoreEmptyCombination [

	| aCombination aStoreString aRestoredCombination |
	aCombination := self testEmptyCombination.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlCompulsoryCombination basicNew instVarAt: 1 put: ((OrderedCollection new)); yourself)'.

	aRestoredCombination := self class compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination
]
