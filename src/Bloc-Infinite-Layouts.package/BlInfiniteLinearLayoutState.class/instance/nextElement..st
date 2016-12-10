recycling
nextElement: aRecycler
	"Get the element for the next item that we should layout.
	Also update current item index to the next item, based on itemDirection."
	<return: #BlElement>

	^ self hasScrapList
		ifTrue: [ self nextElementFromScrapList ]
		ifFalse: [ 
			| anElement |
			anElement := aRecycler elementFor: currentPosition.
			currentPosition := currentPosition + itemDirection multiplier.
			anElement ]