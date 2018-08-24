*Bloc-Sparta
drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
	"I render an underline"
	
	aSpartaCanvas stroke
		paint: self paint;
		path: (aSpartaCanvas shape 
			line: (aSpartaSpan baseline + (2negated@4)) rounded 
			to: (((aSpartaSpan width + aSpartaSpan baseline x) 
						@ aSpartaSpan baseline y) + (2@4) ) rounded);
		width: self width;
		draw