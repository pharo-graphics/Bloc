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
	
	combination key: Key a.
	self assert: (combination combinations asArray collect: #key) equals: { Key a }.
	
	combination key: Key b.
	self assert: (combination combinations asArray collect: #key) equals: { Key a. Key b }.
	
	combination key: Key c.
	self assert: (combination combinations asArray collect: #key) equals: { Key a. Key b. Key c }
]

{ #category : #tests }
BlAlternativeCombinationTest >> testMatch [
	<gtExample>
	self setUp.
	
	buffer pressed: false key: Key a.
	buffer pressed: true key: Key b.
	buffer pressed: false key: Key c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: Key a.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: Key c.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: Key b.
	self assert: (combination match: buffer) equals: 1
]

{ #category : #tests }
BlAlternativeCombinationTest >> testMatches [
	<gtExample>
	self setUp.
	
	buffer pressed: false key: Key a.
	buffer pressed: true key: Key b.
	buffer pressed: false key: Key c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: Key a.
	self assert: (combination matches: buffer) not.
	
	combination key: Key c.
	self assert: (combination matches: buffer) not.
	
	combination key: Key b.
	self assert: (combination matches: buffer)
]
