Class {
	#name : #BlOSSDL3KeyTableTest,
	#superclass : #TestCase,
	#pools : [
		'SDL3KeyConstants'
	],
	#category : #'BlocHost-OSWindow-SDL3-Tests'
}

{ #category : #tests }
BlOSSDL3KeyTableTest >> testKeyMapping [
	| table |
	table := BlOSSDL3KeyTable new.
	
	self assert: (table keyFromVirtualCode: SDLK_A) equals: KeyboardKey A.
	self assert: (table keyFromVirtualCode: SDLK_RETURN) equals: KeyboardKey enter.
	self assert: (table keyFromVirtualCode: SDLK_ESCAPE) equals: KeyboardKey escape.
	self assert: (table keyFromVirtualCode: SDLK_1) equals: KeyboardKey one.
	self assert: (table keyFromVirtualCode: SDLK_LSHIFT) equals: KeyboardKey shiftLeft.
	self assert: (table keyFromVirtualCode: SDLK_SPACE) equals: KeyboardKey space.
]
