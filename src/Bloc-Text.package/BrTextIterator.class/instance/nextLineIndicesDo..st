iterator - enumeration
nextLineIndicesDo: anIndicesBlock
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
		
	self subclassResponsibility