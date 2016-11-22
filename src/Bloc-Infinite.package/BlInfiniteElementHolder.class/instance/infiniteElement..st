private - accessing
infiniteElement: anInfiniteElement
	"Set an infinite element a child of which a hold.
	anInfiniteElement must not be nil"
	self assert: anInfiniteElement isNotNil.
	
	infiniteElement := anInfiniteElement