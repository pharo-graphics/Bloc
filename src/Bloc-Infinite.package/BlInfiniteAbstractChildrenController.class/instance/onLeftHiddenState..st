manager -> element
onLeftHiddenState: aChildElement
	"Notify infinite element that child element is not hidden anymore.
	aChildElement must not be nil"
	
	^ self subclassResponsibility