*Bloc-Sparta
applyOn: aStrokePainter
	"Apply stroke style on a given sparta stroke painter"
	
	aStrokePainter
		dashOffset: self dashOffset;
		dashPattern: self dashArray