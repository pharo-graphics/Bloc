comparing
= aBlCornerRadii
	self species == aBlCornerRadii species
		ifFalse: [ ^ false ].

	^ self bottomLeft = aBlCornerRadii bottomLeft
		and: [ self bottomRight = aBlCornerRadii bottomRight
			and: [ self topLeft = aBlCornerRadii topLeft
				and: [ self topRight = aBlCornerRadii topRight ] ] ]