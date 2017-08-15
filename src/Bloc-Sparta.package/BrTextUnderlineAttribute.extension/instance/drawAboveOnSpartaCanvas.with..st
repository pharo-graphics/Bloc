*Bloc-Sparta
drawAboveOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
	"I render an underline above the text span"
	
	self isAbove
		ifFalse: [ ^ self ].
		
	self drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan