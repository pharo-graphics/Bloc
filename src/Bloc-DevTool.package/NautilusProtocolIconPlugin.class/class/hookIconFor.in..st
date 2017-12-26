protocols
hookIconFor: aString in: aValueHolder
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'hook')
		ifTrue: [ aValueHolder contents: (self iconNamed: #glamorousInto) ]