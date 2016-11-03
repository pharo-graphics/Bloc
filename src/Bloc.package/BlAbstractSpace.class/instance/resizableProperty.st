accessing properties
resizableProperty
	^ resizable ifNil: [ resizable := BlDelegateProperty on: self named: #resizable delegateTo: self hostWindowProperty ]