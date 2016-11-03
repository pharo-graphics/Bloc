predefined instances
BEVEL
	^ Bevel ifNil: [ Bevel := self new beBevel ]