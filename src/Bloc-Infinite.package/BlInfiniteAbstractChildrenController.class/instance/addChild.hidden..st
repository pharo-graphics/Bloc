element -> manager
addChild: aChildElement hidden: aBoolean
	"Adds aChildElement to the element.
	If aBoolean (hidden) is true, aChildElement will be invisible from regular methods.
	aChildElement must not be nil.
	aBoolean must not be nil"
	
	^ self subclassResponsibility