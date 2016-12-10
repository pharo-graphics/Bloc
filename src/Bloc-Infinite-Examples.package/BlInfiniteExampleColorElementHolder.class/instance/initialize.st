initialization
initialize
	super initialize.

	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 3 ];
		addEventHandlerOn: BlClickEvent do: [ :e |
			| aPosition |
			aPosition := e target constraints infinite holder dataSourcePosition.
			e inform: aPosition asString.
			infiniteElement dataSource removeColorAt: aPosition ];
		yourself