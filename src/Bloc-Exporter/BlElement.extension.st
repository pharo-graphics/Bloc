Extension { #name : #BlElement }

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsForm [
	"Export the receiver's image as a Form"
	<return: #Form>

	^ BlExporter form element: self; export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsJPEG [
	"Export the receiver's image as a JPEG"
	<return: #FileReference>

	^ BlExporter jpg element: self; export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsPDF [
	"Export the receiver as a vector PDF"
	<return: #FileReference>

	^ BlExporter pdf element: self; export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsPNG [
	"Export the receiver's image as a PNG"
	<return: #FileReference>

	^ BlExporter png element: self; export
]

{ #category : #'*Bloc-Exporter' }
BlElement >> exportAsSVG [
	"Export the receiver as a SVG"
	<return: #FileReference>

	^ BlExporter svg element: self; export
]
