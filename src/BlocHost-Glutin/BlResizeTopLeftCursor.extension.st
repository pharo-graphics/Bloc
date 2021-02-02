Extension { #name : #BlResizeTopLeftCursor }

{ #category : #'*BlocHost-Glutin' }
BlResizeTopLeftCursor >> asGlutinCursor [
	^ GlutinCursorIcon NwseResize
]
