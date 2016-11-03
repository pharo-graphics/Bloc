initialize-release
initialize
	super initialize.
	selectors := SortedCollection sortBlock: [ :s1 :s2 | s1 specificity >= s2 specificity ].
	declarations := OrderedCollection new.
	transitions := OrderedCollection new