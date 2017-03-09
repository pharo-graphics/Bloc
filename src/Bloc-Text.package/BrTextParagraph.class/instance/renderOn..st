paragraph - rendering
renderOn: aCanvas
	"Render myself on a given canvas.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	self text lockDuring: [ aCanvas renderTextParagraph: self ]