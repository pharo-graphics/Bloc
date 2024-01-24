Extension { #name : #BAFileExporter }

{ #category : #'*Bloc-Deprecated' }
BAFileExporter >> fileName: aFileReference [

	self
		deprecated: 'Use target: instead'
		transformWith: '`@receiver fileName: `@argument'
			-> '`@receiver target: `@argument'.

	self target: aFileReference
]
