computing inequalities
solve: theArcs locations: theLocations modifyOnError: modifyOnError
	| axisName n originalCulprits |
	
	axisName := self horizontal ifTrue: [ 'horizontal' ] ifFalse: [ 'vertical' ].
	n := self count + 1.
	originalCulprits := nil.
	
	0 to: theArcs size - 1 do: [ :p |
		| culprits i break |
		
		self initLocations: theLocations.
			
		n timesRepeat: [ 
			| changed |
			changed := false.
			
			theArcs do: [ :arc | changed := changed | (self relaxLocations: theLocations arc: arc ) ].
	
			changed ifFalse: [ 
				originalCulprits ifNotNil: [ "Warning signal: 'something is bad'" ].
				^ true ] ].
				
		modifyOnError ifFalse: [ ^ false ]. "can not solve"

		culprits := Array new: theArcs size withAll: false.
				
		n timesRepeat: [ 
			arcs withIndexDo: [ :arc :index |
				| culprit |
				culprit := culprits at: index.
				culprits at: index put: (culprit | ( self relaxLocations: theLocations arc: arc ) ) ] ].

		p = 0 ifTrue: [ originalCulprits := culprits ].
				
		i := 1.
		break := false.
				
		[ i <= theArcs size and: [ break not ] ] whileTrue: [ 
			(culprits at: i) ifTrue: [ 
				| arc |
				arc := theArcs at: i.
			
				(arc span first < arc span last) ifFalse: [
					arc valid: false.
					break := true ]	 ].
				i := i + 1 ] ].
	^ true