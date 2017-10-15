matrix - transforming points
transformBounds: aBlBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	| newLeft newTop newRight newBottom aLeft aTop aRight aBottom |

	self isIdentity
		ifTrue: [ ^ aBlBounds ].

	aLeft := aBlBounds left.
	aTop := aBlBounds top.
	aRight := aBlBounds right.
	aBottom := aBlBounds bottom.

	newLeft := self transformX: aLeft withY: aTop.
	newTop := self transformY: aTop withX: aLeft.
	newRight := self transformX: aRight withY: aBottom.
	newBottom := self transformY: aBottom withX: aRight.

	aLeft := newLeft min: newRight.
	aRight := newLeft max: newRight.
	aTop := newTop min: newBottom.
	aBottom := newTop max: newBottom.

	aBlBounds
		left: aLeft
		top: aTop
		right: aRight
		bottom: aBottom.

	^ aBlBounds