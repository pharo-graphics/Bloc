keyboard handlers
handleDelete: anEvent
	| aTextEditElement aText |
	
	aTextEditElement := anEvent currentTarget.
	aText := aTextEditElement text.

	aTextEditElement cursors
		select: [ :aCursor | aCursor hasParent and: [ aCursor textIndex < aText size ] ]
		thenDo: [ :aCursor | aText delete: aCursor textIndex + 1 to: aCursor textIndex + 1 ].

	aTextEditElement text: aText