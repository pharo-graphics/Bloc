accessing
transitions: aTransitionList
	aTransitionList
		do: [ :d | 
			d rule: self.
			d addTo: self ]