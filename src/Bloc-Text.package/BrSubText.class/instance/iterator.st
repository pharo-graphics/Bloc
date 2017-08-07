text - enumeration
iterator
	^ BrSubTextIterator
		text: self
		from: (1 min: self size)
		to: self size