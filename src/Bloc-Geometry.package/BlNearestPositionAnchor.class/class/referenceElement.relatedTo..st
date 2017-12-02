instance creation
referenceElement: anElement relatedTo: anotherElement
	"Some types of achors should take other element into account"
	<return: #BlAnchorRelativeToElement>

	^ self nearestTo: anotherElement from: anElement