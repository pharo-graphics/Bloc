accessing properties
borderlessProperty
	^ borderless ifNil: [ borderless := BlDelegateProperty on: self named: #borderless delegateTo: self hostWindowProperty ]