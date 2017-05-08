accessing
stride
	| bitsPerPixel stride|
	bitsPerPixel := self depth.
	stride := width * bitsPerPixel. 	"bits per row"
	stride := stride + 31.         	"round up to next 32-bit boundary"
	stride := (stride // 32).         "DWORDs per row"
	stride := stride * 4.					"bytes per row"
	^ stride