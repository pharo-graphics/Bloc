transforming points
transformBounds: aBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	| newLeft newTop newRight newBottom aLeft aTop aRight aBottom |

	self isIdentity
		ifTrue: [ ^ aBounds ].

	aLeft := aBounds left.
	aTop := aBounds top.
	aRight := aBounds right.
	aBottom := aBounds bottom.

	newLeft := self transformX: aLeft withY: aTop.
	newTop := self transformY: aTop withX: aLeft.
	newRight := self transformX: aRight withY: aBottom.
	newBottom := self transformY: aBottom withX: aRight.

	aLeft := newLeft min: newRight.
	aRight := newLeft max: newRight.
	aTop := newTop min: newBottom.
	aBottom := newTop max: newBottom.

	aBounds
		left: aLeft
		top: aTop
		right: aRight
		bottom: aBottom.

	^ aBounds