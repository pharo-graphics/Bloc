manager -> element
markElementHoldersUpdated: startPosition itemCount: itemCount payload: aPayloadObject
	"Ask infinite element to update amount of items defined by itemCount
	starting from startPosition with an optional payload object.
	startPosition must not be nil.
	itemCount must not be nil.
	aPayloadObject is optional and may be nil"

	^ self subclassResponsibility