*Bloc-SVG
primTranslateByX: distanceX AndY: distanceY

	self ffiCall: #(void cairo_translate (
			SpartaCairoCanvas canvas,
			double distanceX,
			double distanceY) )