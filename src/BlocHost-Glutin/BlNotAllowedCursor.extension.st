Extension { #name : 'BlNotAllowedCursor' }

{ #category : '*BlocHost-Glutin' }
BlNotAllowedCursor >> asGlutinCursor [
	^ GlutinCursorIcon NotAllowed
]
