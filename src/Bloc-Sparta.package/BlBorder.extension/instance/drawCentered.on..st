*Bloc-Sparta
drawCentered: anElement on: aCanvas
	"Draw a border centered in a given element on a provided Sparta Canvas"

	aCanvas stroke
		paint: self;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: self width;
		in: [ :aPainter | style applyOn: aPainter ];
		draw