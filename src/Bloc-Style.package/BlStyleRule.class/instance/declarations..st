accessing
declarations: aDeclarationList
	aDeclarationList
		do: [ :d | 
			d rule: self.
			d addTo: self ]