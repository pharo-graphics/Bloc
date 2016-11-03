accessing
conditions: aCollection
	aCollection
		do: [ :item | 
			item media: self.
			self conditions add: item ]