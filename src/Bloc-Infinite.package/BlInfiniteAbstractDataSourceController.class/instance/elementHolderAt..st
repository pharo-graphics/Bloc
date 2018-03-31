manager -> element
elementHolderAt: aPosition
	"Ask infinite element to find and return an element holder
	at aPosition or nil of there is no such.
	aPosition must not be nil"
	<return: #BlInfiniteHolder or: nil>
	
	^ self subclassResponsibility