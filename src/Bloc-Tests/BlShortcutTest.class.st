Class {
	#name : 'BlShortcutTest',
	#superclass : 'TestCase',
	#instVars : [
		'shortcut'
	],
	#category : 'Bloc-Tests-KeyBinding',
	#package : 'Bloc-Tests',
	#tag : 'KeyBinding'
}

{ #category : 'initialization' }
BlShortcutTest >> setUp [
	super setUp.
	
	shortcut := BlShortcutWithAction new
]

{ #category : 'tests' }
BlShortcutTest >> testMatches [

	shortcut combination: (BlMockedKeyCombination new shouldMatch: false).
	self assert: (shortcut matches: Object new) not.
	
	shortcut combination: (BlMockedKeyCombination new shouldMatch: true).
	self assert: (shortcut matches: Object new).
]
