*Bloc-Exporter
exportAsJPEG
	"Export the receiver's image as a JPEG"
	<return: #FileReference>

	^ BlExporter jpg element: self; export