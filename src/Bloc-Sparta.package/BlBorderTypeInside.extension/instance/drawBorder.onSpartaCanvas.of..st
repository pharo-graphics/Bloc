*Bloc-Sparta
drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement
	"Draw a border inside of a given element on a provided Sparta Canvas"

	aCanvas stroke
		paint: aBlBorder;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: aBlBorder width * 2.0;	 "we draw inside, so should multiply width by 2"
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw