private - focus
saveFocusInfo
	"I save information of currently focused element in the state.
	In order to restore foces later we need to save item's position
	in data source, its stable it if any and store reference
	to the focused sub child of item's element to give it focus directly"
	| aFocusedElement aFocusedElementHolder |
	
	aFocusedElement := nil.
	
	(preserveFocusAfterLayout and: [ self hasFocus ])
		ifTrue: [ aFocusedElement := self focusedChild ].
	
	aFocusedElementHolder := aFocusedElement
		ifNotNil: [ :anElement | self childHolderContainingItemElement: anElement ].
		
	aFocusedElementHolder
		ifNil: [ self resetFocusInfo ]
		ifNotNil: [ 
			self state focusedItemId: (dataSource hasStableIds
				ifTrue: [ aFocusedElementHolder itemId ]
				ifFalse: [ NoId ]).
			self state focusedItemPosition: (dataSourceChangedAfterLayout
				ifTrue: [ NoPosition ]
				ifFalse: [ aFocusedElementHolder dataSourcePosition ]).
			self state focusedSubChild: (self deepestFocusedChildIn: aFocusedElementHolder itemElement) ]