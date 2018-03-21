api - exporting
export
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		| aForm |
		aForm := aCanvas asForm.
		
		self fileName asFileReference ensureDelete.
		PNGReadWriter putForm: aForm onFileNamed: self fileName.
		
		self fileName asFileReference ]