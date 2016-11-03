computing links
forwardLinks
	<return: #'OrderPreservingDictionary<Interval, BlMutableInt>'>
	
	forwardLinks ifNil: [ forwardLinks := self createLinks: true ].
	
	forwardLinksValid ifFalse: [ 
		self computeLinks: forwardLinks min: true.
		forwardLinksValid := true ].
	
	^ forwardLinks