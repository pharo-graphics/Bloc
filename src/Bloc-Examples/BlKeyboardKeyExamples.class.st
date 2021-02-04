Class {
	#name : #BlKeyboardKeyExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> allKeys [
	<gtExample>
	| allKeys |
	
	allKeys := BlKeyboardKey all.
	self assert: allKeys size > 0.
	
	^ allKeys
]

{ #category : #'instance creation' }
BlKeyboardKeyExamples >> arrowLeft [
	<gtExample>
	| aKey |
	
	aKey := BlKeyboardKey arrowLeft.
	self assert: aKey value equals: nil.
	self assert: aKey name equals: #ArrowLeft.
	
	^ aKey
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeAllKeys [
	<gtExample>
	| allKeys allRestoredKeys |
	
	allKeys := BlKeyboardKey all.
	allRestoredKeys := allKeys collect: [ :eachKey | Object evaluate: eachKey storeString ].
	
	self assert: allRestoredKeys equals: allKeys.
	
	^ allRestoredKeys
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeArrowLeft [
	<gtExample>
	| aKey aStoreString aRestoredKey |
	
	aKey := BlKeyboardKey arrowLeft.
	aStoreString := aKey storeString.
	
	self assert: aStoreString equals: '(BlKeyboardKey new setName: #ArrowLeft; setValue: nil)'.
	
	aRestoredKey := Object evaluate: aStoreString.
	self assert: aRestoredKey equals: aKey.
	
	^ aStoreString
]

{ #category : #'examples - store' }
BlKeyboardKeyExamples >> storeUnknownKey [
	<gtExample>
	| aKey aStoreString aRestoredKey |
	
	aKey := BlKeyboardKey unknown.
	aStoreString := aKey storeString.
	
	self assert: aStoreString equals: '(BlKeyboardKey new setName: #Unknown; setValue: nil)'.
	
	aRestoredKey := Object evaluate: aStoreString.
	self assert: aRestoredKey equals: aKey.
	
	^ aStoreString
]
