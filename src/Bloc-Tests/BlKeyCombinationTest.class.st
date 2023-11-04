"
I am an integration test of all key combinations
"
Class {
	#name : 'BlKeyCombinationTest',
	#superclass : 'TestCase',
	#instVars : [
		'buffer',
		'event',
		'handler'
	],
	#category : 'Bloc-Tests-KeyBinding',
	#package : 'Bloc-Tests',
	#tag : 'KeyBinding'
}

{ #category : 'initialization' }
BlKeyCombinationTest >> setUp [
	super setUp.

	buffer := BlMockedKeyboardBuffer new.
	event := BlShortcutEvent new buffer: buffer.
	handler := BlShortcutHandlerWithShortcuts new.
]

{ #category : 'tests' }
BlKeyCombinationTest >> testKeyCodeCombination [
	| shortcut flag |
	<sampleInstance>
	self setUp.
	flag := false.
	
	buffer pressed: true key: KeyboardKey controlLeft.
	buffer pressed: false key: KeyboardKey controlRight.
	buffer pressed: true key: KeyboardKey altLeft.
	buffer pressed: false key: KeyboardKey altRight.
	buffer pressed: true key: KeyboardKey C.
				
	shortcut := BlShortcutWithAction new
		combination: (BlKeyCombination builder alt; control; key: KeyboardKey C; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag.
]

{ #category : 'tests' }
BlKeyCombinationTest >> testNoMatchKeyCodeCombination [
	| shortcut flag |
	<sampleInstance>
	self setUp.
	flag := false.
	
	buffer pressed: false key: KeyboardKey controlLeft.
	buffer pressed: false key: KeyboardKey controlRight.
	buffer pressed: true key: KeyboardKey altLeft.
	buffer pressed: false key: KeyboardKey altRight.
	buffer pressed: true key: KeyboardKey C.
				
	shortcut := BlShortcutWithAction new
		combination: (BlKeyCombination builder alt; control; key: KeyboardKey C; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag not.
]
