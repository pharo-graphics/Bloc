Extension { #name : #Character }

{ #category : #'*Bloc-Text' }
Character >> textRunOn: aStream [
	"When rendering text we should convert logical items to something that will actually appear
	on the screen and something that can be measured. For example a Tab can not be measured not
	rendered and therefore should be converted to a sequence of spaces"
	
	aStream nextPut: self
]
