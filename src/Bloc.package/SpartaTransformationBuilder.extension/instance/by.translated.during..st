*Bloc-Core
by: aBlElementTransform translated: aPoint during: aBlock

	aBlElementTransform is2D
		ifTrue: [ self by2D: aBlElementTransform translated: aPoint during: aBlock ]
		ifFalse: [ self by3D: aBlElementTransform translated: aPoint during: aBlock ]