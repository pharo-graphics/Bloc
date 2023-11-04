Class {
	#name : 'BlCompulsoryCombinationExamples',
	#superclass : 'BlKeyCombinationExamples',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
BlCompulsoryCombinationExamples >> combinationWithA [

	<gtExample>
	| aCombination |
	aCombination := self emptyCombination.
	aCombination key: KeyboardKey A.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: { KeyboardKey A }.
	self assert: aCombination printString equals: '(A)'.

	^ aCombination
]

{ #category : 'examples - combination' }
BlCompulsoryCombinationExamples >> combinationWithAB [

	<gtExample>
	| aCombination |
	aCombination := self combinationWithA.
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
BlCompulsoryCombinationExamples >> combinationWithABC [

	<gtExample>
	| aCombination |
	aCombination := self combinationWithAB.
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
BlCompulsoryCombinationExamples >> emptyCombination [
	<gtExample>
	| aCombination |
	
	aCombination := BlCompulsoryCombination new.

	self assert: aCombination isCompulsory.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.
 
	^ aCombination
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithA [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithA.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlCompulsoryCombination new with: (BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithAB [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithAB.
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> storeCombinationWithABC [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithABC.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '((((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination) and: (BlKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlCompulsoryCombinationExamples >> storeEmptyCombination [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self emptyCombination.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlCompulsoryCombination new)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]
