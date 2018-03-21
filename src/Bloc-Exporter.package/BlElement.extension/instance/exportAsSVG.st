*Bloc-Exporter
exportAsSVG
	"Export the receiver as a SVG"
	<return: #FileReference>

	^ BlExporter svg element: self; export