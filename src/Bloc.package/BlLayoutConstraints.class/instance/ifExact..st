as yet unclassified
ifExact: aBlock
	(self vertical resizer isExact and: [ self horizontal resizer isExact ])
		ifTrue: aBlock