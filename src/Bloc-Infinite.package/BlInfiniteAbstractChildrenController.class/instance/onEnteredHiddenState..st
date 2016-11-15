manager -> element
onEnteredHiddenState: aChildElement
	"Notify infinite element that child element is now hidden.
	aChildElement must not be nil"
	
	^ self subclassResponsibility