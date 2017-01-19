initialization
resetResources
	
	self checkSession.
	extent := self hostSpace windowExtent.
	scaleFactor := self hostSpace scaleFactor.
	
	spartaCanvas := MozCanvas 
		createExtent: extent
		format: MozSurfaceFormat B8G8R8A8.
		
	spartaCanvas transform
		scaleBy: scaleFactor;
		apply