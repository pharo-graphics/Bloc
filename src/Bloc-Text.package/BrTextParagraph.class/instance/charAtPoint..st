paragraph - geometry
charAtPoint: aPoint
	<return: #Number>
	| aParagraphSpan |

	aParagraphSpan := self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #youself.

	^ aParagraphSpan charAtPoint: aPoint