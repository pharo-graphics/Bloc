initialization
createCairoSurfaceWithExtent: anExtent
	^ hostSpace hostWindow primGetWindow
		primCreateSimilarImageSurfaceFormat: CairoFormatT CAIRO_FORMAT_ARGB32
		w: anExtent x
		h: anExtent y
		scale: 0