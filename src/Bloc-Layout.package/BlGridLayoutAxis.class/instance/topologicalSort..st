computing arcs
topologicalSort: theArcs
	| result cursor arcsByVertex visited walk |
	result := Array new: theArcs size.
	cursor := result size.
	arcsByVertex := self groupArcsByFirstVertex: theArcs.
	visited := Array new: self count + 1 withAll: 0.
	
	walk := nil.
	walk := [ :loc | 
		| status |
		status := visited at: loc.
		status = NEW
			ifTrue: [
				visited at: loc put: PENDING.
				(arcsByVertex at: loc) do: [ :arc |
					walk value: arc span last.
					result at: cursor put: arc.
					cursor := cursor - 1 ].
				visited at: loc put: COMPLETE ].
		status = PENDING
			ifTrue: [ Warning signal: 'Status of visited at ', loc asString, ' should not be PENDING' ] ].
	
	1 to: arcsByVertex size do: [ :loc |
		walk value: loc ].
	
	cursor = 0
		ifFalse: [ Warning signal: 'cursor value should be 0 but was ', cursor asString ].
	
	^ result