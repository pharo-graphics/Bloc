text - enumeration
iterator
	^ BlSubTextIterator
		text: self
		from: (1 min: self size)
		to: self size