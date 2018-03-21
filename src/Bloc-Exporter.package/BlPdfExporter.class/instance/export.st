api - exporting
export
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		aCanvas flush.
		self fileName asFileReference ]