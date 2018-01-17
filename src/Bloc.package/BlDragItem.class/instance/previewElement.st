accessing
previewElement
	^ previewElement ifNil: [ previewElement := self createPreview ]