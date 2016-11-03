grammar media
mediaTypeToken
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]