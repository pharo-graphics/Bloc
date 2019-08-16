Extension { #name : #BlResizeBottomRightCursor }

{ #category : #'*BlocHost-Glutin' }
BlResizeBottomRightCursor >> asGlutinCursor [
	^ GlutinCursorIcon NwseResize
]
