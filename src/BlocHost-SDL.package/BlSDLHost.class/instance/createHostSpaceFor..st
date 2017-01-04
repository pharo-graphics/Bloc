api
createHostSpaceFor: aSpace
	"Create and assign a new sdl host space for given bloc space"
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHost not ]
		description: [ 'Space must not have a host!' ].
		
	aWindow := self createSDLWindowFor: aSpace.

	aHostSpace := BlSDLSpace new 
		sdlWindow: aWindow;
		withSpartaRendereer.

	self registerHostSpace: aHostSpace.
	aSpace hostSpace: aHostSpace