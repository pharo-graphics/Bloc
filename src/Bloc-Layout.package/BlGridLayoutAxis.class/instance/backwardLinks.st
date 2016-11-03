computing links
backwardLinks
	<return: #'OrderPreservingDictionary<Interval, BlMutableInt>'>
	
	backwardLinks ifNil: [ backwardLinks := self createLinks: false ].
	
	backwardLinksValid ifFalse: [ 
		self computeLinks: backwardLinks min: false.
		backwardLinksValid := true ].
	
	^ backwardLinks