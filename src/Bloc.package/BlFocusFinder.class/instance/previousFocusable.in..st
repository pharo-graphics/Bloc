private - accessing
previousFocusable: anElement in: aCollection
	"Return a previous focusable element before a given element within provided collection.
	If anElement is nil I return the last element from a collection or nil if it is empty"
	<return: #BlElement or: nil>

	^ anElement
		ifNotNil: [ | position |
			position := aCollection lastIndexOf: anElement.
			position > 1
				ifTrue: [ aCollection at: position - 1 ]
				ifFalse: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection last ] ] ]
		ifNil: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection last ] ]