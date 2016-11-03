accessing properties
extentProperty
	^ extent ifNil: [ extent := BlExtentProperty on: self named: #extent ]