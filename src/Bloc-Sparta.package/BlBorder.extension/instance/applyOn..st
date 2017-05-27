*Bloc-Sparta
applyOn: aStrokePainter
	"Apply border stroke style on a given sparta stroke painter"
	
	aStrokePainter
		width: self width;
		paint: self paint.

	self style applyOn: aStrokePainter