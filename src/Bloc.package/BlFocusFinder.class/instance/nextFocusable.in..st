private - accessing
nextFocusable: anElement in: aCollection
	"Return a next focusable element after a given element within provided collection.
	If anElement is nil I return the first element from a collection or nil if it is empty"
	<return: #BlElement or: nil>

	^ anElement
		ifNotNil: [ | position |
			position := aCollection lastIndexOf: anElement.
			(position > 0 and: [ position + 1 <= aCollection size ])
				ifTrue: [ aCollection at: position + 1 ]
				ifFalse: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection first ] ] ]
		ifNil: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection first ] ]