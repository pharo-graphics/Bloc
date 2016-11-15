manager -> element
childAt: anIndex
	"Return a child that is at anIndex in children collection
	of infinite element or nil if anIndex is out of range.
	anIndex must not be nil"
	<return: #BlElement or: nil>
	
	^ self subclassResponsibility