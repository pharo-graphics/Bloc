I am a special Paint type background given as a ===BlPaint===.

Example:

	BlPaintBackground paint: Color red
	
	or
	
	BlPaintBackground new
		paint: (BlLinearGradientPaint new
			stops: { 0 -> Color red . 1 -> Color blue};
			start: 0@0;
			end: 100@100);
		yourself
		
Opacity example:

	BlPaintBackground new
		opacity: 0.5;
		paint: (BlRadialGradientPaint new
			stops: { 0 -> Color blue . 1 -> Color red};
			center: 100@100;
			radius: 200);
		yourself