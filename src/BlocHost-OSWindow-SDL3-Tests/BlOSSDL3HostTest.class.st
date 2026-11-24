Class {
	#name : #BlOSSDL3HostTest,
	#superclass : #TestCase,
	#pools : [
		'SDL3KeyConstants'
	],
	#category : #'BlocHost-OSWindow-SDL3-Tests'
}

{ #category : #tests }
BlOSSDL3HostTest >> testDriverClassName [

	self assert: BlOSSDL3Host driverClassName equals: #OSSDL3Driver.
	self assert: BlOSSDL3GPUHost driverClassName equals: #OSSDL3GPUDriver
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostKeyMapping [

	| table |
	table := BlOSSDL3GPUHost default keyboardKeyTable.
	self assert: (table keyFromVirtualCode: SDLK_A) equals: KeyboardKey A.
	self assert: (table keyFromVirtualCode: SDLK_RETURN) equals: KeyboardKey enter.
	self assert: (table keyFromVirtualCode: SDLK_ESCAPE) equals: KeyboardKey escape.
	self assert: (table keyFromVirtualCode: SDLK_1) equals: KeyboardKey one.
	self assert: (table keyFromVirtualCode: SDLK_LSHIFT) equals: KeyboardKey shiftLeft.
	self assert: (table keyFromVirtualCode: SDLK_SPACE) equals: KeyboardKey space
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostNewAttributesForSpace [

	| space attributes |
	space := BlSpace new.
	space title: 'Test Window'.
	space extent: 800@600.
	attributes := BlOSSDL3GPUHost default newAttributesFor: space.
	self assert: attributes title equals: 'Test Window'.
	self assert: attributes extent equals: 800@600.
	self deny: attributes visible
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostNewHostSpaceFor [

	| space hostSpace |
	BlOSSDL3GPUHost isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	[
		hostSpace := BlOSSDL3GPUHost default newHostSpaceFor: space.
		self assert: hostSpace class equals: BlOSSDL3GPUHostSpace.
		self assert: hostSpace host equals: BlOSSDL3GPUHost default.
		self assert: hostSpace space equals: space
	] ensure: [
		hostSpace ifNotNil: [ hostSpace close ] ]
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostRendererResetsNeedsFlushAndHandlesZeroExtent [

	| space formRenderer resizedForm |
	BlOSSDL3GPUHost isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	space useSDLHost.
	space extent: 300 @ 200.
	[
		space open; settle.
		formRenderer := space hostSpace osWindow renderer formRenderer.
		resizedForm := Form extent: 360 @ 240 depth: 32.
		formRenderer form: resizedForm.
		formRenderer updateToNewResolution.
		self assert: formRenderer extent equals: 360 @ 240.
		self deny: formRenderer needsFlush.

		formRenderer form: (Form extent: 0 @ 0 depth: 32).
		formRenderer updateToNewResolution.
		formRenderer flush.
		self assert: formRenderer extent equals: 360 @ 240.
		self deny: formRenderer needsFlush
	] ensure: [
		space close; settle ]
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostResizeUpdatesBackingFormAndTexture [

	| space child osWindow gpuRenderer initialForm attempts expandedPixel |
	BlOSSDL3GPUHost isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	space useSDLHost.
	space extent: 400 @ 300.
	child :=
		BlElement new
			background: Color red;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.
	space root addChild: child.
	[
		space open; settle.
		osWindow := space hostSpace osWindow.
		gpuRenderer := osWindow renderer.
		initialForm := gpuRenderer form.
		self assert: initialForm extent equals: osWindow canvasExtent.
		self assert: gpuRenderer formRenderer extent equals: osWindow canvasExtent.
		self assert: child extent equals: 400.0 @ 300.0.

		gpuRenderer resized.
		self assert: gpuRenderer form == initialForm.

		attempts := 0.
		osWindow extent: 640 @ 420.
		[ (space root extent ~= (640.0 @ 420.0) or: [ gpuRenderer form extent ~= osWindow canvasExtent ]) and: [ attempts < 100 ] ]
			whileTrue: [
				attempts := attempts + 1.
				(Delay forMilliseconds: 20) wait ].
		space settle.
		self assert: space extent equals: 640 @ 420.
		self assert: child extent equals: 640.0 @ 420.0.
		self assert: gpuRenderer form extent equals: osWindow canvasExtent.
		self assert: gpuRenderer formRenderer extent equals: osWindow canvasExtent.
		expandedPixel := gpuRenderer form colorAt: gpuRenderer form extent - (10 @ 10).
		self assert: expandedPixel red > 0.9.
		self assert: expandedPixel green < 0.1.
		self assert: expandedPixel blue < 0.1.

		attempts := 0.
		space extent: 320 @ 240.
		[ (osWindow extent ~= (320 @ 240) or: [ space root extent ~= (320.0 @ 240.0) ]) and: [ attempts < 100 ] ]
			whileTrue: [
				attempts := attempts + 1.
				(Delay forMilliseconds: 20) wait ].
		space settle.
		self assert: space extent equals: 320 @ 240.
		self assert: child extent equals: 320.0 @ 240.0.
		self assert: gpuRenderer form extent equals: osWindow canvasExtent.
		self assert: gpuRenderer formRenderer extent equals: osWindow canvasExtent
	] ensure: [
		space close; settle ]
]

{ #category : #tests }
BlOSSDL3HostTest >> testGPUHostUseSDLHost [

	| space |
	BlOSSDL3GPUHost isSupported ifFalse: [ ^ self skip ].

	space := BlSpace new.
	space useSDLHost.
	[
		space open.
		space settle.
		self assert: space host equals: BlOSSDL3GPUHost default.
		self assert: space host isRunning.
		self assert: (space host spaces includes: space)
	] ensure: [
		space close; settle ]
]

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
	self
		deny: attributes visible
		description: 'Initially not visible to avoid a race condition'
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
BlOSSDL3HostTest >> testOrder [

	self assert: BlOSSDL3Host order equals: 10.
	self assert: BlOSSDL3GPUHost order equals: 10
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
