"
I am an integration test of all key combinations
"
Class {
	#name : #BlKeyCombinationTest,
	#superclass : #TestCase,
	#instVars : [
		'buffer',
		'event',
		'handler'
	],
	#category : 'Bloc-Tests-KeyBinding'
}

{ #category : #initialization }
BlKeyCombinationTest >> setUp [
	super setUp.

	buffer := BlMockedKeyboardBuffer new.
	event := BlShortcutEvent new buffer: buffer.
	handler := BlShortcutHandler new.
]

{ #category : #tests }
BlKeyCombinationTest >> testKeyCodeCombination [
	| shortcut flag |
	<gtExample>
	self setUp.
	flag := false.
	
	buffer pressed: true key: Key leftControl.
	buffer pressed: false key: Key rightControl.
	buffer pressed: true key: Key leftAlt.
	buffer pressed: false key: Key rightAlt.
	buffer pressed: true key: Key c.
				
	shortcut := BlShortcut new
		combination: (BlKeyCombination builder alt; control; key: Key c; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag.
]

{ #category : #tests }
BlKeyCombinationTest >> testNoMatchKeyCodeCombination [
	| shortcut flag |
	<gtExample>
	self setUp.
	flag := false.
	
	buffer pressed: false key: Key leftControl.
	buffer pressed: false key: Key rightControl.
	buffer pressed: true key: Key leftAlt.
	buffer pressed: false key: Key rightAlt.
	buffer pressed: true key: Key c.
				
	shortcut := BlShortcut new
		combination: (BlKeyCombination builder alt; control; key: Key c; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag not.
]
