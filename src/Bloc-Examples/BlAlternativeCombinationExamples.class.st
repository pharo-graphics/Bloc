Class {
	#name : 'BlAlternativeCombinationExamples',
	#superclass : 'BlKeyCombinationExamplesTest',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testCombinationWithA [

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
BlAlternativeCombinationExamples >> testCombinationWithAB [

	<sampleInstance>
	| aCombination |
	aCombination := self testCombinationWithA.
	aCombination key: KeyboardKey B.

	self
		assert: (aCombination combinations asArray collect: #key)
		equals: {
				KeyboardKey A.
				KeyboardKey B }.
	self assert: aCombination printString equals: '(A | B)'.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testCombinationWithABC [

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
	self assert: aCombination printString equals: '(A | B | C)'.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testEmptyCombination [

	<sampleInstance>
	| aCombination |
	aCombination := BlAlternativeCombination new.

	self assert: aCombination isAlternative.
	self assert: aCombination combinations isEmpty.
	self assert: aCombination printString equals: '()'.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testMatchCombinationWithA [

	<sampleInstance>
	| aCombination aBuffer |
	aCombination := self testCombinationWithA.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: KeyboardKey A.
	aBuffer pressed: false key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	self assert: (aCombination match: aBuffer) equals: 1.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testMatchCombinationWithAB [

	<sampleInstance>
	| aCombination aBuffer |
	aCombination := self testCombinationWithAB.

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
BlAlternativeCombinationExamples >> testNoMatchCombinationWithA [

	<sampleInstance>
	| aCombination aBuffer |
	aCombination := self testCombinationWithA.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: false key: KeyboardKey A.
	aBuffer pressed: true key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	self assert: (aCombination match: aBuffer) equals: 0.

	^ aCombination
]

{ #category : 'examples - combination' }
BlAlternativeCombinationExamples >> testNoMatchCombinationWithAB [

	<sampleInstance>
	| aCombination aBuffer |
	aCombination := self testCombinationWithAB.

	aBuffer := BlMockedKeyboardBuffer new.
	aBuffer pressed: true key: KeyboardKey A.
	aBuffer pressed: true key: KeyboardKey B.
	aBuffer pressed: false key: KeyboardKey C.

	"it should be precise match"
	self assert: (aCombination match: aBuffer) equals: 0.

	^ aCombination
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> testStoreCombinationWithA [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithA.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlAlternativeCombination new with: (BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> testStoreCombinationWithAB [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithAB.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'(((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> testStoreCombinationWithABC [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testCombinationWithABC.
	aStoreString := aCombination storeString.

	self
		assert: aStoreString
		equals:
		'((((BlKeyboardKey new setName: #A; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #B; setValue: nil) asKeyCombination) or: (BlKeyboardKey new setName: #C; setValue: nil) asKeyCombination)'.

	aRestoredCombination := Object evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]

{ #category : 'examples - store' }
BlAlternativeCombinationExamples >> testStoreEmptyCombination [

	<sampleInstance>
	| aCombination aStoreString aRestoredCombination |
	aCombination := self testEmptyCombination.
	aStoreString := aCombination storeString.

	self assert: aStoreString equals: '(BlAlternativeCombination new)'.

	aRestoredCombination := Object compiler evaluate: aStoreString.
	self assert: aRestoredCombination equals: aCombination.

	^ aStoreString
]
