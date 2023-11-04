Class {
	#name : 'BlSingleKeyCombinationExamples',
	#superclass : 'BlKeyCombinationExamples',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
BlSingleKeyCombinationExamples >> arrowLeftCombination [
	<gtExample>
	| aKeyCombination |
	
	aKeyCombination := self arrowLeft asKeyCombination.
	self assert: (aKeyCombination isKindOf: BlSingleKeyCombination).
	self assert: aKeyCombination key equals: self arrowLeft.
	
	^ aKeyCombination
]

{ #category : 'examples - store' }
BlSingleKeyCombinationExamples >> storeArrowLeftCombination [
	<gtExample>
	| aKeyCombination aStoreString aRestoredKeyCombination |
	
	aKeyCombination := self arrowLeftCombination.
	aStoreString := aKeyCombination storeString.
	
	self assert: aStoreString equals: '(BlKeyboardKey new setName: #ArrowLeft; setValue: nil) asKeyCombination'.
	
	aRestoredKeyCombination := Object evaluate: aStoreString.
	self assert: aRestoredKeyCombination equals: aKeyCombination.
	
	^ aStoreString
]
