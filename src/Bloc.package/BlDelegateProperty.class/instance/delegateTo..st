delegation
delegateTo: aProperty
	aProperty addChangeListener: self.
	property := aProperty.
	