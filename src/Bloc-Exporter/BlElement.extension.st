Extension { #name : #BlElement }

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsForm [
	"Export the receiver's image as a Form. Answer a `Form`."

	^ BlExporter form
		  element: self;
		  export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsJPEG [
	"Export the receiver's image as a JPEG. Answer the target (a `FileReference`)."

	^ BlExporter jpg
		  element: self;
		  export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsPDF [
	"Export the receiver as a vector PDF. Answer the target (a `FileReference`)"

	^ BlExporter pdf
		  element: self;
		  export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsPNG [
	"Export the receiver's image as a PNG. Answer the target (a `FileReference`)"

	^ BlExporter png
		  element: self;
		  export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsSVG [
	"Export the receiver as a SVG. Answer the target (a `FileReference`)"

	^ BlExporter svg
		  element: self;
		  export
]
