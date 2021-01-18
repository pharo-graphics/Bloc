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
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #initialization }
BlKeyCombinationTest >> setUp [
	super setUp.

	buffer := BlMockedKeyboardBuffer new.
	event := BlShortcutEvent new buffer: buffer.
	handler := BlShortcutHandlerWithShortcuts new.
]

{ #category : #tests }
BlKeyCombinationTest >> testKeyCodeCombination [
	| shortcut flag |
	<gtExample>
	self setUp.
	flag := false.
	
	buffer pressed: true key: BlKeyboardKey controlLeft.
	buffer pressed: false key: BlKeyboardKey controlRight.
	buffer pressed: true key: BlKeyboardKey altLeft.
	buffer pressed: false key: BlKeyboardKey altRight.
	buffer pressed: true key: BlKeyboardKey c.
				
	shortcut := BlShortcutWithAction new
		combination: (BlKeyCombination builder alt; control; key: BlKeyboardKey c; build);
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
	
	buffer pressed: false key: BlKeyboardKey controlLeft.
	buffer pressed: false key: BlKeyboardKey controlRight.
	buffer pressed: true key: BlKeyboardKey altLeft.
	buffer pressed: false key: BlKeyboardKey altRight.
	buffer pressed: true key: BlKeyboardKey c.
				
	shortcut := BlShortcutWithAction new
		combination: (BlKeyCombination builder alt; control; key: BlKeyboardKey c; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag not.
]
