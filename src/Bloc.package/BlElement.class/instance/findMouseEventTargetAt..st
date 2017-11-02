event handling
findMouseEventTargetAt: aPoint
	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child found and if I can not be event target either"
	<return: #BlElement or: nil>

	^ self children zSorted
			detect: [ :anElement | anElement wantsMouseEventAt: aPoint ]
			ifFound: [ :anElement | anElement findMouseEventTargetAt: aPoint ]
			ifNone: [ (self wantsMouseEventAt: aPoint)
				ifTrue: [ self ]
				ifFalse: [ nil ] ]