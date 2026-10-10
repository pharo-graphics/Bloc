Class {
	#name : #BlOSSDL3HostTest,
	#superclass : #TestCase,
	#pools : [
		'SDL3KeyConstants'
	],
	#category : #'BlocHost-OSWindow-SDL3-Tests'
}

{ #category : #tests }
BlOSSDL3HostTest >> testKeyMapping [

	| table |
	table := BlOSSDL3Host default keyboardKeyTable.

	self assert: (table keyFromVirtualCode: SDLK_A) equals: KeyboardKey A.
	self assert: (table keyFromVirtualCode: SDLK_RETURN) equals: KeyboardKey enter.
	self assert: (table keyFromVirtualCode: SDLK_ESCAPE) equals: KeyboardKey escape.
	self assert: (table keyFromVirtualCode: SDLK_1) equals: KeyboardKey one.
	self assert: (table keyFromVirtualCode: SDLK_LSHIFT) equals: KeyboardKey shiftLeft.
	self assert: (table keyFromVirtualCode: SDLK_SPACE) equals: KeyboardKey space
]

{ #category : #tests }
BlOSSDL3HostTest >> testNewAttributesForSpace [

	| space attributes |
	space := BlSpace new.
	space title: 'Test Window'.
	space extent: 800@600.

	attributes := BlOSSDL3Host default newAttributesFor: space.
	self assert: attributes title equals: 'Test Window'.
	self assert: attributes extent equals: 800@600.
	self assert: attributes visible not. "Visible should be false initially to avoid race condition"
]

{ #category : #tests }
BlOSSDL3HostTest >> testNewHostSpaceFor [

	| space hostSpace |
	BlOSSDL3Host isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	[
		hostSpace := BlOSSDL3Host default newHostSpaceFor: space.
		self assert: hostSpace class equals: BlOSSDL3SimpleHostSpace.
		self assert: hostSpace host equals: BlOSSDL3Host default.
		self assert: hostSpace space equals: space
	] ensure: [
		hostSpace ifNotNil: [ hostSpace close ] ]
]

{ #category : #tests }
BlOSSDL3HostTest >> testUseSDLHost [

	| space |
	BlOSSDL3Host isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	space useSDLHost.
	[
		space open.
		space settle.
		self assert: space host equals: BlOSSDL3Host default.
		self assert: space host isRunning.
		self assert: (space host spaces includes: space)
	] ensure: [
		space close; settle ]
]
