instance creation
referenceElement: anElement relatedTo: anotherElement
	"Some types of achors should take other element into account"
	<return: #BlAnchorRelativeToElement>

	"By default most we only care about a single reference element"
	^ self element: anElement