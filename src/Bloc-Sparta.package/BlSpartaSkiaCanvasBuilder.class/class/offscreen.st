instance creation
offscreen
	<return: #SpartaCanvas>

	^ (self environment at: #SkiaOffscreenCanvas) uniqueInstance