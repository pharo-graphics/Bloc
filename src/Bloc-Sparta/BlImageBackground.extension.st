Extension { #name : #BlImageBackground }

{ #category : #'*Bloc-Sparta' }
BlImageBackground >> bitmapOn: aCanvas [
	"Return a cached bitmap surface for the image, or create a new one if it does not exist"
	<return: #TSpartaSurface>

	session == Smalltalk session
		ifFalse: [
			bitmap := nil.
			session := Smalltalk session ].
	^ bitmap ifNil: [ bitmap := aCanvas bitmap fromForm: self image ]
]

{ #category : #'*Bloc-Sparta' }
BlImageBackground >> drawOnSpartaCanvas: aCanvas of: anElement [
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	aCanvas fill
		alpha: self opacity;
		paint: (self bitmapOn: aCanvas);
		path: (anElement geometry pathOnSpartaCanvas: aCanvas);
		draw
]
