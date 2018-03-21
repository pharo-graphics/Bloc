*Bloc-Exporter
exportAsPNG
	"Export the receiver's image as a PNG"
	<return: #FileReference>

	^ BlExporter png element: self; export