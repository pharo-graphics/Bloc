host - api
createHostSpaceFor: aSpace
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHost not ]
		description: [ 'Space must not have a host!' ].
	
	aWindow := self createGtkWindowFor: aSpace.
	aHostSpace := BlGtkSpace new 
		hostWindow: aWindow;
		withSpartaRendereer.
		
	self registerHostSpace: aHostSpace.
	aSpace hostSpace: aHostSpace