initialization
subsetFrom: aBlChildren
	^ aBlChildren select: [ :anElement | anElement constraints ignoredByLayout ]