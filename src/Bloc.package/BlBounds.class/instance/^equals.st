comparing
= aRectangle
	"Answer true if the receiver's species, origin and corner match aRectangle's."

	^ (self species = aRectangle species or: [ aRectangle isRectangle ])
		and: [ top = aRectangle top
			and: [ right = aRectangle right
				and: [ bottom = aRectangle bottom
					and: [ left = aRectangle left ] ] ] ]