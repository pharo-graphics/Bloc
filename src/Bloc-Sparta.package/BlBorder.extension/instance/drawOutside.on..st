*Bloc-Sparta
drawOutside: anElement on: aCanvas
	"Draw a border outside of a given element on a provided Sparta Canvas"

	aCanvas stroke
		paint: self;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: self width * 2.0;	 "we draw outside, so should multiply width by 2"
		in: [ :aPainter | style applyOn: aPainter ];
		draw