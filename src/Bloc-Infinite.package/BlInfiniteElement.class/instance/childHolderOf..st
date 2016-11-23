private
childHolderOf: aChildElement
	"Return an element holder assigned to aChildElement.
	Element holder can not be nil"
	<return: #BlInfiniteElementHolder>
	
	^ aChildElement constraints infinite holder