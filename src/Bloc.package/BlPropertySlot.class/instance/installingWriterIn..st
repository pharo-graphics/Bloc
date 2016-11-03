as yet unclassified
installingWriterIn: aClass
	|  writer | 
	
	
	writer := String streamContents: [ :str |
		str 
			nextPutAll: self name;
			nextPutAll: ': anObject';
			cr;tab;
			nextPutAll: self name;
			nextPutAll: ' value: anObject.'.
		].
	
	self compileMethod: writer class: aClass protocol: self accessingProtocol
	