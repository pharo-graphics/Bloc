as yet unclassified
installingReaderIn: aClass
	| reader  | 
	
	reader := String streamContents: [ :str |
		str 
			nextPutAll: self name;
			cr;tab;
			nextPutAll: ' ^';
			nextPutAll: self name;
			nextPutAll: ' value'
		 ].
	
	self compileMethod: reader class: aClass protocol: self accessingProtocol
