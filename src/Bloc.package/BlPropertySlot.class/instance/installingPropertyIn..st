as yet unclassified
installingPropertyIn: aClass
	| property |
	property := String
		streamContents:
			[ :str | 
			str
				nextPutAll: self name;
				nextPutAll: 'Property';
				cr;
				tab;
				nextPutAll: ' ^';
				nextPutAll: self name ].
			
	self compileMethod: property class: aClass protocol: self accessingPropertyProtocol