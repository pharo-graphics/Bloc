Class {
	#name : #BlElementLocationAnchor,
	#superclass : #BlElementGeometryAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementLocationAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| w h x1 y1 pt |
	pt := self valueInBounds: aRectangle.
	w := pt x.
	h := pt y.
	x1 := aValue x - w.
	y1 := aValue y - h.
	^ BlBounds
		  origin: x1 @ y1
		  corner: (x1 + aRectangle width) @ (y1 + aRectangle height)
]
