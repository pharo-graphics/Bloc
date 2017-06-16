*Bloc-Sparta
drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement
	"Draw a border outside of a given element on a provided Sparta Canvas"

	aCanvas stroke
		paint: aBlBorder paint;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: aBlBorder width * 2.0;	 "we draw outside, so should multiply width by 2"
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw