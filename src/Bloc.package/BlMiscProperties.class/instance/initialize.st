initialization
initialize
	super initialize.
	managed := true.
	clipChildren := true.
	userData := IdentityDictionary new.
	debug := false.
	label := ''