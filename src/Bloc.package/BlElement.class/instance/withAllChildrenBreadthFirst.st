children accessing
withAllChildrenBreadthFirst
	| all |
	all := OrderedCollection with: self.
	self allChildrenBreadthFirstDo: [ :x | all add: x ].
	^ all