*Bloc-Sparta
drawBelowOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
	"I render background under text span"

	aSpartaCanvas fill
		paint: paint;
		path: (aSpartaSpan origin extent: aSpartaSpan extent);
		draw