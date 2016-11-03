accessing
selectors: aCollection
	aCollection
		do: [ :item |  self selectors add: (item rule: self rule; yourself) ]