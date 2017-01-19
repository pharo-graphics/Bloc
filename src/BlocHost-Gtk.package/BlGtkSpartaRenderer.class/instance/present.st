initialization
present
	self validate ifFalse: [ ^ self ].

	cairoContext := self createCairoContext.
	cairoSurface := CairoSurfaceT primCreateForData: self spartaCanvas data 
		format: CairoFormatT  CAIRO_FORMAT_ARGB32
		w: self spartaCanvas extent x
		h: self spartaCanvas extent y
		stride: self spartaCanvas stride.

	cairoContext primSetOperator: CairoOperatorT CAIRO_OPERATOR_SOURCE.
	cairoContext primSetSourceSurface: cairoSurface x: 0 y: 0.
	cairoContext primPaint.
	cairoContext primDestroy.
	cairoSurface primDestroy.
	
	"hostSpace hostWindow primQueueDraw"
	