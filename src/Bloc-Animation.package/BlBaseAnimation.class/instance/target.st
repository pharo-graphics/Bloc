accessing
target
	target ifNil:[ self parent ifNotNil:[:p| ^ p target]].
	^ target