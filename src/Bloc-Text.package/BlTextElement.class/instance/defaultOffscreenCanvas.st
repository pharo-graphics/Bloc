initialization
defaultOffscreenCanvas
	"Return an offscreen canvas used to measure text.
	It must be of the same type and backend as rendering canvas"
	<return: #SpartaCanvas>

	^ Bloc preferableSpartaCanvas offscreen