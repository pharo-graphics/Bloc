focus
focusedChild
	"Return direct child of infinite element which has focus or contains the focused child"
	<return: #BlElement or: nil>
	| focusedChild |
	
	focusedChild := infiniteElement focusedChild.
	^ (focusedChild isNil or: [ childManager isHidden: focusedChild ])
		ifTrue: [ nil ]
		ifFalse: [ focusedChild ]