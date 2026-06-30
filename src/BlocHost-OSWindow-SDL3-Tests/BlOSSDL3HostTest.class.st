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
	table := BlOSSDL3Host new keyboardKeyTable.
	
	self assert: (table keyFromVirtualCode: SDLK_A) equals: KeyboardKey A.
	self assert: (table keyFromVirtualCode: SDLK_RETURN) equals: KeyboardKey enter.
	self assert: (table keyFromVirtualCode: SDLK_ESCAPE) equals: KeyboardKey escape.
	self assert: (table keyFromVirtualCode: SDLK_1) equals: KeyboardKey one.
	self assert: (table keyFromVirtualCode: SDLK_LSHIFT) equals: KeyboardKey shiftLeft.
	self assert: (table keyFromVirtualCode: SDLK_SPACE) equals: KeyboardKey space
]

{ #category : #tests }
BlOSSDL3HostTest >> testNewAttributesForSpace [

	| host space attributes |
	host := BlOSSDL3Host new.
	space := BlSpace new.
	space title: 'Test Window'.
	space extent: 800@600.
	
	attributes := host newAttributesFor: space.
	self assert: attributes title equals: 'Test Window'.
	self assert: attributes extent equals: 800@600.
	self assert: attributes visible not. "Visible should be false initially to avoid race condition"
]

{ #category : #tests }
BlOSSDL3HostTest >> testNewHostSpaceFor [

	| host space hostSpace |
	host := BlOSSDL3Host new.
	space := BlSpace new.
	hostSpace := host newHostSpaceFor: space.
	
	self assert: hostSpace class equals: BlOSSDL3SimpleHostSpace.
	self assert: hostSpace host equals: host.
	self assert: hostSpace space equals: space
]

{ #category : #tests }
BlOSSDL3HostTest >> testUseSDL3Host [

	| space host |
	space := BlSpace new.
	space useSDL3Host.
	self assert: space host class equals: BlOSSDL3Host.
	
	host := space host.
	host start.
	self assert: host isRunning.
	self assert: host class label equals: 'SDL3'.
	self assert: host class priority equals: 10.
	self assert: host class isSupported.
]
