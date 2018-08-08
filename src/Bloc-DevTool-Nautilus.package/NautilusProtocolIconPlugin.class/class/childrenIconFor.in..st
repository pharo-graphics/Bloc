protocols
childrenIconFor: aString in: aValueHolder
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'children')
		ifTrue: [ aValueHolder contents: ((Form extent: 16@16 depth: 32)
				copy: (2@2 extent: 16@16)
				from: 0@0
				in: (self iconNamed: #smallHierarchyBrowser)
				rule: Form over) ]