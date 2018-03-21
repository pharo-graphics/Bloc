api - exporting
export
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		| aForm |
		
		aForm := aCanvas asForm.
	
		self fileName asFileReference ensureDelete.
		PluginBasedJPEGReadWriter
			putForm: aForm
			quality: self quality
			progressiveJPEG: self isProgressive
			onFileNamed: self fileName.
		
		self fileName asFileReference ]