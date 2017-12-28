geometry bounds
inParent
	self assertNotOriginal.
	
	"If reference element does not have parent local bounds can
	be treated as bounds in parent, so just return self"
	self referenceElement hasParent
		ifFalse: [ ^ self ].

	self localBoundsToParent: bounds.

	"Update our reference element to be a parent of the current reference element"
	referenceElement := self referenceElement parent