api - running
enqueue
	self target ifNotNil: [ :anElement | anElement enqueueTask: self ]