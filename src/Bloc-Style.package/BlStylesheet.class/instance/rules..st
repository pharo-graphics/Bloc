accessing
rules: aCollection
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]