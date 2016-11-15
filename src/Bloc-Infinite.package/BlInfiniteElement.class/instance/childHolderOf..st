private
childHolderOf: aChildElement
	"Return an element holder assigned to aChildElement
	or nil if it is not assigned"
	<return: #BlInfiniteHolder or: nil>
	
	^ aChildElement constraints holder