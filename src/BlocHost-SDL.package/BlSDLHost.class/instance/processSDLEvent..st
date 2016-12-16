private
processSDLEvent: sdlEvent
	| mappedEvent blocEvent hostSpace|
	
	mappedEvent := sdlEvent mapped ifNil: [ ^ self ].
	mappedEvent windowID ifNil: [ ^ self  ].
	
	hostSpace := hostSpaces at: mappedEvent windowID ifAbsent: [ ^ self ].
	hostSpace sdlWindow ifNil:[^ self].
	blocEvent := self convertSDLEvent: mappedEvent hostSpace: hostSpace.
	hostSpace ifNotNil:[:hs| hs enqueueEvent: blocEvent].
	BlUniverse default requestNextPulse
	