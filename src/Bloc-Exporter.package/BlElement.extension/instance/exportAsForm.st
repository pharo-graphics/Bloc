*Bloc-Exporter
exportAsForm
	"Export the receiver's image as a Form"
	<return: #Form>

	^ BlExporter form element: self; export