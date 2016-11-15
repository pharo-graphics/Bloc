element -> manager
attachChildToParent: aChildElement at: anIndex hidden: aBoolean
	"Attaches aChildElement to the underlying infinite element at anIndex
	of the child to attach in regular perspective.
	If isHidden is set to true, child will be invisible to the regular methods.
	aChildElement must not be nil.
	anIndex must nor be nil and must be >= 0.
	aBoolean must not be nil"

	^ self subclassResponsibility