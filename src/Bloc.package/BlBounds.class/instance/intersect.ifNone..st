rectangle functions
intersect: aRectangle ifNone: aBlock
	"Answer a Rectangle that is the area in which the receiver overlaps with 
	aRectangle. 
	If there's no overlap, evaluate the block instead"
	| aLeft aTop aRight aBottom newLeft newTop newRight newBottom |

	(self intersects: aRectangle)
		ifFalse: [ ^ aBlock value ].
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.
	
	newLeft := aLeft max: left.
	newTop := aTop max: top.
	newRight := aRight min: right.
	newBottom := aBottom min: bottom.

	^ self class new
		left: newLeft
		top: newTop
		right: newRight
		bottom: newBottom