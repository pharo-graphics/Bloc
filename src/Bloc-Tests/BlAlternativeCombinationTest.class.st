Class {
	#name : #BlAlternativeCombinationTest,
	#superclass : #TestCase,
	#instVars : [
		'combination',
		'buffer'
	],
	#category : 'Bloc-Tests-KeyBinding'
}

{ #category : #initialization }
BlAlternativeCombinationTest >> setUp [
	super setUp.
	
	combination := BlAlternativeCombination new.
	buffer := BlMockedKeyboardBuffer new
]

{ #category : #tests }
BlAlternativeCombinationTest >> testInitialize [
	<gtExample>
	self setUp.

	self assert: combination combinations isEmpty
]

{ #category : #tests }
BlAlternativeCombinationTest >> testKey [
	<gtExample>
	self setUp.

	self assert: combination combinations isEmpty.
	
	combination key: BlKeyboardKey a.
	self assert: (combination combinations asArray collect: #key) equals: { BlKeyboardKey a }.
	
	combination key: BlKeyboardKey b.
	self assert: (combination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b }.
	
	combination key: BlKeyboardKey c.
	self assert: (combination combinations asArray collect: #key) equals: { BlKeyboardKey a. BlKeyboardKey b. BlKeyboardKey c }
]

{ #category : #tests }
BlAlternativeCombinationTest >> testMatch [
	<gtExample>
	self setUp.
	
	buffer pressed: false key: BlKeyboardKey a.
	buffer pressed: true key: BlKeyboardKey b.
	buffer pressed: false key: BlKeyboardKey c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: BlKeyboardKey a.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: BlKeyboardKey c.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: BlKeyboardKey b.
	self assert: (combination match: buffer) equals: 1
]

{ #category : #tests }
BlAlternativeCombinationTest >> testMatches [
	<gtExample>
	self setUp.
	
	buffer pressed: false key: BlKeyboardKey a.
	buffer pressed: true key: BlKeyboardKey b.
	buffer pressed: false key: BlKeyboardKey c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: BlKeyboardKey a.
	self assert: (combination matches: buffer) not.
	
	combination key: BlKeyboardKey c.
	self assert: (combination matches: buffer) not.
	
	combination key: BlKeyboardKey b.
	self assert: (combination matches: buffer)
]
