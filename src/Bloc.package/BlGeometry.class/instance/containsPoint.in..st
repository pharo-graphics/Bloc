geometry testing
containsPoint: aPoint in: aBlElement
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	<return: #Boolean>

	^ self
		containsPoint: aPoint
		in: aBlElement
		on: Bloc preferableSpartaCanvas offscreen