Extension { #name : #Character }

{ #category : #'*Bloc-Text' }
Character class >> nel [
	"Answer the Character representing next line."

	^self value: 16r85
]

{ #category : #'*Bloc-Text' }
Character >> textRunOn: aStream [
	"When rendering text we should convert logical items to something that will actually appear
	on the screen and something that can be measured. For example a Tab can not be measured not
	rendered and therefore should be converted to a sequence of spaces"

	self asciiValue = 9 ifTrue: "tab"
		[ aStream nextPutAll: '    ' ]
	ifFalse: [ self asciiValue = 16r85 ifTrue: "nel"
		[ aStream nextPutAll: String crlf ]
	ifFalse: [ aStream nextPut: self ] ]
]
