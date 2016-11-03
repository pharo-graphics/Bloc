computing arcs
groupArcsByFirstVertex: theArcs
	"theArcs is collection of BlGridLayoutArc."
	
	| n groups sizes |
	n := self count + 1.
	groups := Array new: n.
	sizes := Array new: n withAll: 0.

	theArcs do: [ :arc |
		sizes at: arc span first incrementBy: 1 ].
	
	sizes withIndexDo: [ :size :index |
		groups at: index put: (Array new: size) ].
	
	sizes := Array new: n withAll: 1.
	theArcs do: [ :arc |
		|index|
		index := arc span first.
		(groups at: index) at: (sizes at: index) put: arc.
		sizes at: index incrementBy: 1 ].
	^ groups