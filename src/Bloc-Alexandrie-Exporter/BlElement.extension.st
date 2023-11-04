Extension { #name : 'BlElement' }

{ #category : '*Bloc-Alexandrie-Exporter' }
BlElement >> exportAsForm [
	"Export the receiver's image as a Form. Answer a `Form`."

	^ BAExporter form
		  element: self;
		  export
]

{ #category : '*Bloc-Alexandrie-Exporter' }
BlElement >> exportAsJPEG [
	"Export the receiver's image as a JPEG. Answer the target (a `FileReference`)."

	^ BAExporter jpg
		  element: self;
		  export
]

{ #category : '*Bloc-Alexandrie-Exporter' }
BlElement >> exportAsPDF [
	"Export the receiver as a vector PDF. Answer the target (a `FileReference`)"

	^ BAExporter pdf
		  element: self;
		  export
]

{ #category : '*Bloc-Alexandrie-Exporter' }
BlElement >> exportAsPNG [
	"Export the receiver's image as a PNG. Answer the target (a `FileReference`)"

	^ BAExporter png
		  element: self;
		  export
]

{ #category : '*Bloc-Alexandrie-Exporter' }
BlElement >> exportAsSVG [
	"Export the receiver as a SVG. Answer the target (a `FileReference`)"

	^ BAExporter svg
		  element: self;
		  export
]
