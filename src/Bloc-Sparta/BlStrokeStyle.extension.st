Extension { #name : #BlStrokeStyle }

{ #category : #'*Bloc-Sparta' }
BlStrokeStyle >> applyOn: aStrokePainter [
	"Apply stroke style on a given sparta stroke painter"
	
	aStrokePainter
		dashOffset: self dashOffset;
		dashPattern: self dashArray;
		miterLimit: self miterLimit.
		
	self lineCap applyOn: aStrokePainter.
	self lineJoin applyOn: aStrokePainter
]
