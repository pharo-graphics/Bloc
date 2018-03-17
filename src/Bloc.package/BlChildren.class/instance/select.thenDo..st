children - enumerating
select: selectBlock thenDo: doBlock
	"Utility method to improve readability.
	Do not create the intermediate collection."
	
	self do: [ :anElement |
		(selectBlock value: anElement)
			ifTrue: [ doBlock value: anElement ] ]