text - attributes
attributesAt: anIndex
	"Return a collection of text attributes without duplicates at a given text index"
	<return: #Collection of: #BrTextAttribute>

	^ (self iterator: anIndex to: anIndex) attributes