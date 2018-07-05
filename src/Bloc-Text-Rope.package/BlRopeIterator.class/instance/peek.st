iterator - enumeration
peek
	"Return an element at current #position without changing it.
	(#peek item is the same that was returned by #next or #previous)"
	<return: #Object>

	^ self subclassResponsibility