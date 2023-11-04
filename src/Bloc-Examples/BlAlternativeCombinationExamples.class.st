Class {
	#name : 'BlAlternativeCombinationExamples',
	#superclass : 'BlKeyCombinationExamples',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithA [
	<gtExample>
	| aCombination |
	
	aCombination := self emptyCombination.
	aCombination key: KeyboardKey A.

	self assert: (aCombination combinations asArray collect: #key) equals: { KeyboardKey A }.
	self assert: aCombination printString equals: '(A)'.
	
	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithAB [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithA.
	aCombination key: KeyboardKey B.

	self assert: (aCombination combinations asArray collect: #key) equals: { KeyboardKey A. KeyboardKey B }.
	self assert: aCombination printString equals: '(A | B)'.
	
	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> combinationWithABC [
	<gtExample>
	| aCombination |
	
	aCombination := self combinationWithAB.	
	aCombination key: KeyboardKey C.

	self assert: (aCombination combinations asArray collect: #key) equals: { KeyboardKey A. KeyboardKey B. KeyboardKey C }.
	self assert: aCombination printString equals: '(A | B | C)'.
	
	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> emptyCombination [
	<gtExample>
	| aCombination |
	
	aCombination := BlAlternativeCombination new.

	self assert: aCombination isAlternative.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.
 
	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithA [

	<gtExample>
	| aCombination aBuffer |
	aCombination := self combinationWithA.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: KeyboardKey A.
	aBuffer pressed: false key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	self assert: (aCombination match: aBuffer) equals: 1.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> matchCombinationWithAB [

	<gtExample>
	| aCombination aBuffer |
	aCombination := self combinationWithAB.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: KeyboardKey A.
	aBuffer pressed: true key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: KeyboardKey A.
	aBuffer pressed: false key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 1.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithA [

	<gtExample>
	| aCombination aBuffer |
	aCombination := self combinationWithA.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: KeyboardKey A.
	aBuffer pressed: true key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	self assert: (aCombination match: aBuffer) equals: 0.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> noMatchCombinationWithAB [

	<gtExample>
	| aCombination aBuffer |
	aCombination := self combinationWithAB.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: KeyboardKey A.
	aBuffer pressed: true key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 0.

	^ aCombination
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithA [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithA.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination new with: (BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithAB [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithAB.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> storeCombinationWithABC [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self combinationWithABC.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '((((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> storeEmptyCombination [
	<gtExample>
	| aCombination aStoreString aRestoredCombination |
	
	aCombination := self emptyCombination.	
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination new)'.
	
	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.
	
	^ aStoreString
]
