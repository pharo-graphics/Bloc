children - geometry
decoratedEndInParent: anElement
	"Return the end of the Element after its matrix transformations are applied to its layout position.
	I am useful when trying to detect the visible edge of an element.
	Note: It include the decorations but do not include the margins"
	<return: #Number>
	
	^ self subclassResponsibility