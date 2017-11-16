*Bloc-Sparta
bitmapOn: aCanvas
	"Return a cached bitmap surface for the image, or create a new one if it does not exist"
	<return: #TSpartaSurface>

	session == Smalltalk session
		ifFalse: [
			bitmap := nil.
			session := Smalltalk session ].
	^ bitmap ifNil: [ bitmap := aCanvas bitmap fromForm: self image ]