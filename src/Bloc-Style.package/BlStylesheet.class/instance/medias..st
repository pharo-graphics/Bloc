accessing
medias: aCollection
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]