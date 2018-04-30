accessing
owner: anElement
	super owner: anElement.
	
	anElement when: BlElementPositionChange do: [ self invalidateMatrix ]