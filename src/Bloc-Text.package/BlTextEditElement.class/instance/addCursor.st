cursor - management
addCursor
	"Create, add and return a new cursor element"
	<return: #BlTextCursorElement>
	| aCursor |

	aCursor := self defaultCursor.
	self addChild: aCursor.
	self cursors add: aCursor.
	^ aCursor