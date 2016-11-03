accessing properties
extentProperty
	^ extent ifNil: [ extent := BlDelegateProperty on: self named: #extent delegateTo: self hostWindowProperty ]