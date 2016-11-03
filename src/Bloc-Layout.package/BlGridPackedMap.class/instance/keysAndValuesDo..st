accessing
keysAndValuesDo: aBlock

	1 to: self keys size do: [ :i | aBlock value: (self keys at: i) value: (self values at: i) ]