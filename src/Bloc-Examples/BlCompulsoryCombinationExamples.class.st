Class {
	#name : 'BlCompulsoryCombinationExamples',
	#superclass : 'BlKeyCombinationExamplesTest',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
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

{ #category : 'examples - combination' }
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

{ #category : 'examples - combination' }
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

{ #category : 'examples - combination' }
BlCompulsoryCombinationExamples >> testEmptyCombination [

	<sampleInstance>
	| aCombination |
	aCombination := BlCompulsoryCombination new.

	self assert: aCombination isCompulsory.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.

	^ aCombination
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithA [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithA.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlCompulsoryCombination new with: (BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithAB [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithAB.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> testStoreCombinationWithABC [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithABC.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'((((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> testStoreEmptyCombination [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testEmptyCombination.
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlCompulsoryCombination new)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]
