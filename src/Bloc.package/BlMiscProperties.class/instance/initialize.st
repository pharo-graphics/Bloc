initialization
initialize
	super initialize.
	mouseTransparent := false.
	managed := true.
	clipChildren := true.
	userData := IdentityDictionary new.
	debug := false.
	label := ''