protocols
updateIconFor: aString in: aValueHolder
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'update')
		ifTrue: [ aValueHolder contents: (self iconNamed: #smallUpdate) ]