paragraph - geometry
indexAtPosition: aPoint
	<return: #Number>
	| aParagraphSpan |

	aParagraphSpan := self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself.

	^ aParagraphSpan indexAtPosition: aPoint