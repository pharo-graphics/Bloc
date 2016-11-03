as yet unclassified
ifFitContent: aBlock
	(self vertical resizer isFitContent and: [ self horizontal resizer isFitContent ])
		ifTrue: aBlock