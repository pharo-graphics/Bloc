children
preferableChildrenDataStructure
	<return: #'BlChildrenCollection class'>

	^ PreferableChildrenDataStructure ifNil: [ self defaultChildrenDataStructure ]