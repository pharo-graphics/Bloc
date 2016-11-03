computing locations
relaxLocations: theLocations arc: arc
	"locations is array of integers.
	arc is BlGridLayoutArc"
	<return: #Boolean>
	| span u v value candidate |
	
	arc valid
		ifFalse: [ ^ false ].
	
	span := arc span.
	u := span first.
	v := span last.
	value := arc value value.
	candidate := (theLocations at: u) + value.
	
	^ (candidate > (theLocations at: v))
		ifTrue: [ 
			theLocations at: v put: candidate.
			true ]
		ifFalse: [ false ]