vector-transform
transformRectangle: aSpartaRectangle
	"In-place transform rectangle according to my transformation.
	(local to global transformation)"
	| newLeft newTop newRight newBottom aLeft aTop aRight aBottom |

	self isIdentity
		ifTrue: [ ^ aSpartaRectangle ].

	aLeft := aSpartaRectangle left.
	aTop := aSpartaRectangle top.
	aRight := aSpartaRectangle right.
	aBottom := aSpartaRectangle bottom.

	newLeft := self transformX: aLeft with: aTop.
	newTop := self transformY: aTop with: aLeft.
	newRight := self transformX: aRight with: aBottom.
	newBottom := self transformY: aBottom with: aRight.

	aLeft := newLeft min: newRight.
	aRight := newLeft max: newRight.
	aTop := newTop min: newBottom.
	aBottom := newTop max: newBottom.

	aSpartaRectangle
		left: aLeft
		top: aTop
		right: aRight
		bottom: aBottom.

	^ aSpartaRectangle