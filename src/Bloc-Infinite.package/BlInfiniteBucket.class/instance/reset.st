accessing
reset
	next ifNotNil: #reset.
	array := self newArray