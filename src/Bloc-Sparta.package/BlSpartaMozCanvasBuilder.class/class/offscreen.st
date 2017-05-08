instance creation
offscreen
	<return: #SpartaCanvas>

	^ (self environment at: #MozOffscreenCanvas) uniqueInstance