accessing
isSupported
	<return: #Boolean>

	^ (self environment includesKey: #MozCanvas)
		and: [ (self environment at: #MozLibrary) uniqueInstance hasModule ]