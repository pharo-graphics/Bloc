Extension { #name : #BARenderer }

{ #category : #'*Bloc-Alexandrie-Exporter' }
BARenderer class >> write: aBlElement asPngTo: aFileReference [
	"Draw the element into a PNG at the specified location."

	BAExporter png
			target: aFileReference;
			element: aBlElement;
			export
]
