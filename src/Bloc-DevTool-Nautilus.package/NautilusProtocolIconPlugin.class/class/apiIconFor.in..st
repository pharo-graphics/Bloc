protocols
apiIconFor: aString in: aValueHolder
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'api')
		ifTrue: [ aValueHolder contents: (self iconNamed: #protocolPublicIcon) ]