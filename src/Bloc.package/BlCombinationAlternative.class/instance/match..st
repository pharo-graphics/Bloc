accessing
match: anEventBuffer
	^ alternative anySatisfy: [ :each | each match: anEventBuffer ]