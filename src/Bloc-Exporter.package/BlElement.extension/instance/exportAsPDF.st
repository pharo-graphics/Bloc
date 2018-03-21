*Bloc-Exporter
exportAsPDF
	"Export the receiver as a vector PDF"
	<return: #FileReference>

	^ BlExporter pdf element: self; export