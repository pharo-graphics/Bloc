api - selection
deselect: aSelection
	"Remove a given selection"

	aSelection do: [ :aMonotoneSelection | self remove: aMonotoneSelection ]