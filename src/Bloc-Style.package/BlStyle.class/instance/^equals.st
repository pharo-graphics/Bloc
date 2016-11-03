comparing
= aStyle
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]