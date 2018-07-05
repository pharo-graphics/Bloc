children - removing
removeAll: aCollectionOfBlElement
	aCollectionOfBlElement do: [ :aChild | self remove: aChild ]