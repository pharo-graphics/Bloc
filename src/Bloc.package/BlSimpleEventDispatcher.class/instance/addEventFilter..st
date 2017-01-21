adding/removing
addEventFilter: aFilter
	
	"It is not very common to have event filters so we initialize registry lazily"
	filters ifNil: [
		filters := self defaultFilterRegistry ].
	filters add: aFilter.

	"send hook AFTER filter is added"
	aFilter onInstalledIn: self owner