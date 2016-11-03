accessing properties
fullscreenProperty
	^ fullscreen ifNil: [ fullscreen := BlDelegateProperty on: self named: #fullscreen delegateTo: self hostWindowProperty ]