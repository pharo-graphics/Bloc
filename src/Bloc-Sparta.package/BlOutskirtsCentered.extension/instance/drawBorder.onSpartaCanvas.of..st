*Bloc-Sparta
drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement
	"Draw a border centered in a given element on a provided Sparta Canvas"

	aCanvas stroke
		alpha: aBlBorder opacity;
		paint: aBlBorder paint;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: aBlBorder width;
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw