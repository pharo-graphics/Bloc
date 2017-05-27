instance creation
extentTextFor: aPoint
	| string |
	
	string := (aPoint x printShowingDecimalPlaces: 3), ' x ', (aPoint y printShowingDecimalPlaces: 3).
	^ BrRopedText string: string