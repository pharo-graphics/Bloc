*Bloc-SVG
visualBoundsInParent
	"Override the BlElement function because BlLine doesn't behave like other BlGeometries"
	|boundsInParent|
	boundsInParent:=self boundsInParent.
	
	^Rectangle origin: boundsInParent origin - self border width
		corner: boundsInParent corner + self border width