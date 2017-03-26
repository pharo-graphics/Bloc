focus accessing
focusedChild
	"Return my direct child that is focused or contains a focused child, if any. The child may have or contain focus.
	I may return nil of there is no such child"
	<return: #BlElement or: nil>

	^ self children
		detect: [ :anElement | anElement hasFocus ]
		ifNone: [ nil ]