iterator - accessing
attributes
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #Objects>

	^ BlAttributeRope
		mergeAttributes: subIterator attributes
		and: rope attributes