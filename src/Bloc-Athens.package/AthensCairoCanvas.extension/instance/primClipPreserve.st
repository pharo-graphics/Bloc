*Bloc-Athens
primClipPreserve
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
	
	^ self nbCall: #(void cairo_clip_preserve (self))