as yet unclassified
ifMatchParent: aBlock
	(self vertical resizer isMatchParent and: [ self horizontal resizer isMatchParent ])
		ifTrue: aBlock