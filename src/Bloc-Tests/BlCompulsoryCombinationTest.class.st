Class {
	#name : #BlCompulsoryCombinationTest,
	#superclass : #TestCase,
	#instVars : [
		'combination',
		'buffer'
	],
	#category : 'Bloc-Tests-KeyBinding'
}

{ #category : #initialization }
BlCompulsoryCombinationTest >> setUp [

	super setUp.

	combination := BlCompulsoryCombination new.
	buffer := BlMockedKeyboardBuffer new
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testInitialize [

	<sampleInstance>
	self setUp.

	self assert: combination combinations isEmpty
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testKey [

	<sampleInstance>
	self setUp.

	self assert: combination combinations isEmpty.

	combination key: KeyboardKey A.
	self
		assert: (combination combinations asArray collect: #key)
		equals: { KeyboardKey A }.

	combination key: KeyboardKey B.
	self
		assert: (combination combinations asArray collect: #key)
		equals: {
				KeyboardKey A.
				KeyboardKey B }.

	combination key: KeyboardKey C.
	self
		assert: (combination combinations asArray collect: #key)
		equals: {
				KeyboardKey A.
				KeyboardKey B.
				KeyboardKey C }
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testMatch [

	<sampleInstance>
	<noTest>
	self setUp.

	buffer pressed: false key: KeyboardKey A.
	buffer pressed: true key: KeyboardKey B.
	buffer pressed: true key: KeyboardKey C.

	self assert: (combination match: buffer) equals: 0.

	combination key: KeyboardKey C.
	self assert: (combination match: buffer) equals: 0.

	combination key: KeyboardKey B.
	self assert: (combination match: buffer) equals: 0.

	combination key: KeyboardKey A.
	self assert: (combination match: buffer) equals: 0
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testMatches [

	<sampleInstance>
	self setUp.

	buffer pressed: true key: KeyboardKey A.
	buffer pressed: false key: KeyboardKey B.
	buffer pressed: true key: KeyboardKey C.

	self assert: (combination matches: buffer) not.

	combination key: KeyboardKey A.
	self assert: (combination matches: buffer) not.

	combination key: KeyboardKey C.
	self assert: (combination matches: buffer).

	combination key: KeyboardKey B.
	self assert: (combination matches: buffer) not
]
