initialization
initialize
	super initialize.

	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40 ];
		addEventHandlerOn: BlClickEvent do: [ :e |
			| aPosition |
			aPosition := e target constraints infinite holder dataSourcePosition.
			infiniteElement dataSource moveColorDownAt: aPosition ];
		yourself