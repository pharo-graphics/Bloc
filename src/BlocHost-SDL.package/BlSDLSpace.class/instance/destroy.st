displaying
destroy
	sdlWindow ifNotNil: [ :validHandle | validHandle destroy ].
	renderer := nil.
	sdlWindow := nil