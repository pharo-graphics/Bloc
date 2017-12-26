protocols
debugIconFor: aString in: aValueHolder
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'debug')
		ifTrue: [ aValueHolder contents: (self iconNamed: #smallDebug) ]