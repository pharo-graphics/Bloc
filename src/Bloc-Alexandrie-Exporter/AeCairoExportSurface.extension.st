Extension { #name : #AeCairoExportSurface }

{ #category : #'*Bloc-Alexandrie-Exporter' }
AeCairoExportSurface >> extent [
	"Export surfaces (PDF, SVG) are not pixel-bounded, answer an unbounded extent for canvas clipping."

	^ SmallFloat64 maxExactInteger @ SmallFloat64 maxExactInteger
]
