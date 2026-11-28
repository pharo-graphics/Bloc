Class {
	#name : #BlKeyboardProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'processor',
		'space'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #running }
BlKeyboardProcessorTest >> setUp [

	super setUp.
	
	space := BlSpace new.
	processor := BlKeyboardProcessor space: space
]

{ #category : #running }
BlKeyboardProcessorTest >> tearDown [

	super tearDown.

	processor := nil.
	space := nil
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDown [

	| eventA |
	eventA := BlKeyDownEvent new.
	eventA key: KeyboardKey A.

	processor processKeyDown: eventA.
	self assert: processor areKeystrokesAllowed.
	self assert: (processor buffer hasEvent: KeyboardKey A)
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDownDuplicateIgnoredWhenNotRepeated [

	| eventA duplicateEventA firedEvents |
	firedEvents := OrderedCollection new.
	space root addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		firedEvents add: anEvent ].

	eventA :=
		BlKeyDownEvent new
			key: KeyboardKey A;
			yourself.
	processor processKeyDown: eventA.
	self assert: firedEvents size equals: 1.

	duplicateEventA :=
		BlKeyDownEvent new
			key: KeyboardKey A;
			yourself.
	processor processKeyDown: duplicateEventA.
	self assert: firedEvents size equals: 1
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDownNonRepeatableShortcut [

	| shortcutExecutionCount shortcut |
	shortcutExecutionCount := 0.
	shortcut :=
		BlShortcutWithAction new
			combination: (BlSingleKeyCombination key: KeyboardKey A);
			repeatable: false;
			action: [ shortcutExecutionCount := shortcutExecutionCount + 1 ];
			yourself.
	space root addShortcut: shortcut.

	processor processKeyDown: (BlKeyDownEvent new
		key: KeyboardKey A;
		yourself).
	self assert: shortcutExecutionCount equals: 1.

	processor processKeyDown: (BlKeyDownEvent new
		key: KeyboardKey A;
		isRepeated: true;
		yourself).
	self assert: shortcutExecutionCount equals: 1
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDownRepeat [

	| eventA repeatedEventA keyDownEvents shortcutEvents |
	keyDownEvents := OrderedCollection new.
	shortcutEvents := OrderedCollection new.
	space root addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keyDownEvents add: anEvent ].
	space root addEventHandlerOn: BlShortcutEvent do: [ :anEvent |
		shortcutEvents add: anEvent ].

	eventA :=
		BlKeyDownEvent new
			key: KeyboardKey A;
			yourself.
	processor processKeyDown: eventA.
	self assert: keyDownEvents size equals: 1.
	self deny: keyDownEvents first isRepeated.
	self assert: shortcutEvents size equals: 1.
	self deny: shortcutEvents first isRepeated.

	repeatedEventA :=
		BlKeyDownEvent new
			key: KeyboardKey A;
			isRepeated: true;
			yourself.
	processor processKeyDown: repeatedEventA.
	self assert: keyDownEvents size equals: 2.
	self assert: keyDownEvents second isRepeated.
	self assert: shortcutEvents size equals: 2.
	self assert: shortcutEvents second isRepeated
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDownRepeatableShortcut [

	| shortcutExecutionCount shortcut |
	shortcutExecutionCount := 0.
	shortcut :=
		BlShortcutWithAction new
			combination: (BlSingleKeyCombination key: KeyboardKey A);
			repeatable: true;
			action: [ shortcutExecutionCount := shortcutExecutionCount + 1 ];
			yourself.
	space root addShortcut: shortcut.

	processor processKeyDown: (BlKeyDownEvent new
		key: KeyboardKey A;
		yourself).
	self assert: shortcutExecutionCount equals: 1.

	processor processKeyDown: (BlKeyDownEvent new
		key: KeyboardKey A;
		isRepeated: true;
		yourself).
	self assert: shortcutExecutionCount equals: 2
]
