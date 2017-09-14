*Bloc-SVG
primScaleContextByX: factorX AndY: factorY

	self ffiCall: #(void cairo_scale (
			SpartaCairoCanvas canvas,
			double factorX,
			double factorY) )