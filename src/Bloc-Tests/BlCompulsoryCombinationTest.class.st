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
	<gtExample>
	self setUp.
	
	self assert: combination combinations isEmpty
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testKey [
	<gtExample>.
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
BlCompulsoryCombinationTest >> testMatch [
	<gtExample>
	self setUp.
	
	buffer pressed: false key: Key a.
	buffer pressed: true key: Key b.
	buffer pressed: true key: Key c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: Key a.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: Key c.
	self assert: (combination match: buffer) equals: 1.
	
	combination key: Key b.
	self assert: (combination match: buffer) equals: 2
]

{ #category : #tests }
BlCompulsoryCombinationTest >> testMatches [
	<gtExample>.
	self setUp.

	buffer pressed: true key: Key a.
	buffer pressed: false key: Key b.
	buffer pressed: true key: Key c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: Key a.
	self assert: (combination matches: buffer).
	
	combination key: Key c.
	self assert: (combination matches: buffer).
	
	combination key: Key b.
	self assert: (combination matches: buffer) not
]
