accessing properties
titleProperty
	^ title ifNil: [ title := BlDelegateProperty on: self named: #title delegateTo: self hostWindowProperty ]