manager -> element
markElementHoldersUpdated: aStartPosition itemCount: anItemCount payload: aPayloadObject
	"Ask infinite element to update amount of items defined by itemCount
	starting from aStartPosition with an optional payload object.
	aStartPosition must not be nil.
	anItemCount must not be nil.
	aPayloadObject is optional and may be nil"

	^ self subclassResponsibility