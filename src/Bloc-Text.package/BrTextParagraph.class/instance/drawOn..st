paragraph - rendering
drawOn: aCanvas
	"Render myself on a given canvas.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	session == Smalltalk session
		ifFalse: [ self measureOn: aCanvas ].

	self text lockDuring: [ aCanvas drawTextParagraph: self ]