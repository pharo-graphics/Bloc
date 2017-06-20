accessing
isSupported
	<return: #Boolean>
	
	^ (self environment includesKey: #SkiaCanvas) and: [ (self environment at: #SkiaCanvas) isSupported ]