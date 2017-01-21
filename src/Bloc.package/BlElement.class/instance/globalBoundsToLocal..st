geometry bounds convertion
globalBoundsToLocal: aRectangle
	| r aTransformed |

	aTransformed := transform globalBoundsToLocal: aRectangle.
	r := self parent
		ifNil: [ aTransformed ]
		ifNotNil: [ :p | p globalBoundsToLocal: aTransformed ].

	^ r translateBy: self position negated