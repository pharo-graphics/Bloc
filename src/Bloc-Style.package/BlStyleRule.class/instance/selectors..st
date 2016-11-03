accessing
selectors: anObject
	selectors := anObject.
	selectors do: [ :s | s rule: self ]