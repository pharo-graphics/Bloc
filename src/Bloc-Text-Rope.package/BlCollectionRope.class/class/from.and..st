instance creation
from: aLeftRope and: aRightRope
	| length array index |
	length := aLeftRope size + aRightRope size.
	array := Array new: length.
	index := 1.
	aLeftRope do: [ :item | array at: index put: item. index := index + 1 ].
	aRightRope do: [ :item | array at: index put: item. index := index + 1 ].
	^ self collection: array