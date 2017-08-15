*Bloc-Sparta
drawBelowOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
	"I render an underline under the text span"
	
	self isBelow
		ifFalse: [ ^ self ].

	self drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan