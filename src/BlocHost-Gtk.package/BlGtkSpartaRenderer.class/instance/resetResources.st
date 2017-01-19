initialization
resetResources
	| extent |
	self checkSession.
	extent := self hostSpace windowExtent.
	spartaCanvas := MozCanvas 
		createExtent: extent x @ extent y
		format: MozSurfaceFormat B8G8R8A8.