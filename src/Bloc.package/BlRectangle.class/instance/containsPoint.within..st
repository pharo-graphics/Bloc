geometry testing
containsPoint: aPoint within: aBounds

"check if aPoint is in the basic rectangle"

	|w h isBottomSide isRightSide center radius maxRadius|
	w := aBounds extent x.
	h := aBounds extent y.
	maxRadius := self cornerRadii max.
	"check if aPoint is in the rectangle minus the corner radius"
	(aPoint x > maxRadius and: [ aPoint x <= (w - maxRadius) ])
		ifTrue: [ ^ true ].
	(aPoint y > maxRadius and: [ aPoint y <= (h - maxRadius) ])
		ifTrue: [ ^ true ].
	"check if aPoint is in the corner triangles"
	isRightSide := aPoint x > (w / 2).
	isBottomSide := aPoint y > (h / 2).
	"top left circle"
	(isRightSide not and: isBottomSide not)
		ifTrue: [ center := self cornerRadii topLeft asPoint.
			radius := self cornerRadii topLeft ].
	"top right circle"
	(isRightSide and: isBottomSide not)
		ifTrue: [ center := w @ 0 + (self cornerRadii topRight negated @ self cornerRadii topRight).
			radius := self cornerRadii topRight ].
	"bottom right circle"
	(isRightSide and: isBottomSide)
		ifTrue: [ center := (w@h)- self cornerRadii bottomRight asPoint.
			radius := self cornerRadii bottomRight ].
	"bottom left circle"
	(isRightSide not and: isBottomSide)
		ifTrue: [ center := 0 @ h + (self cornerRadii bottomLeft @ self cornerRadii bottomLeft negated).
			radius := self cornerRadii bottomLeft ].
	"check if it is in the defined circle"
	^ (aPoint x - center x) squared + (aPoint y - center y) squared <= radius squared