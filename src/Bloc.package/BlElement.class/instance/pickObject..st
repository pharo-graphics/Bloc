picking
pickObject: aPoint
	| theZChildren i c |
	(self containsGlobalPoint: aPoint) ifFalse: [ ^ nil ].
	i := 1.
	theZChildren := self children zSorted.
	[ i <= theZChildren size ] whileTrue: [
		c := theZChildren at: i.
		(c isVisible and: [ c isMouseTransparent not and: [ c containsGlobalPoint: aPoint ] ])
				ifTrue: [ ^ c pickObject: aPoint ].
		i := i + 1 ]