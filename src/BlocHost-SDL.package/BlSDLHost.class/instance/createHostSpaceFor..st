host - api
createHostSpaceFor: aSpace
	"Create and assign a new sdl host space for given bloc space"
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
		
	aWindow := self createSDLWindowFor: aSpace.

	aHostSpace := BlSDLSpace new 
		host: self;
		sdlWindow: aWindow.

	SkiaCanvas isSupported
		"Use OpenGL if available"
		ifTrue: [ aHostSpace withSkiaRendereer ]
		ifFalse: [ aHostSpace withSpartaRenderer ].

	self registerHostSpace: aHostSpace.
	aSpace hostSpace: aHostSpace