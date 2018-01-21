api - adding/removing
addEventFilter: aFilter
	"Event filters receive events before general event handlers.
	Their main goal is to prevent some specific events from being handled by basic handlers.
	For that custom filters should mark event as ==consumed: true== which instantly stops propagation"

	"It is not very common to have event filters so we initialize registry lazily"
	filters ifNil: [
		filters := self defaultFilterRegistry ].
	filters add: aFilter.

	"send hook AFTER filter is added"
	aFilter onInstalledIn: self owner