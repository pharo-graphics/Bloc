children accessing
childAtPosition: aPosition
	"Finds the element which represents the given datasource position.
	I traverse each child since I have no information about child order.
	Override me to improve performance if your infinite layout keeps data about child elements"
	<return: #BlElement or: nil>
	
	1 to: self childrenCount do: [ :anIndex |
		| anElement anElementHolder |
		anElement := self childAt: anIndex.
		anElementHolder := self childHolderOf: anElement.
		anElementHolder ifNotNil: [ :aHolder | 
			(aHolder layoutPosition = aPosition and: [
				aHolder shouldIgnore not and: [ 
					self state isPreLayout or: [ 
						aHolder isRemoved not ] ] ])
				ifTrue: [ ^ anElement ] ] ].
	^ nil