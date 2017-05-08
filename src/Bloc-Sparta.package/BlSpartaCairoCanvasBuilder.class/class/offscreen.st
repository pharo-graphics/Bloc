instance creation
offscreen
	<return: #SpartaCanvas>

	^ (self environment at: #SpartaCairoOffscreenCanvas) uniqueInstance