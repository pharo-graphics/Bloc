as yet unclassified
convertKeyModifiersFromModState: modState 
	| shift ctrl alt gui |
	
	shift := (modState bitAnd: KMOD_SHIFT) ~= 0.
	ctrl := (modState bitAnd: KMOD_CTRL) ~= 0.
	alt := (modState bitAnd: KMOD_LALT) ~= 0.
	gui := (modState bitAnd: KMOD_GUI) ~= 0.
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd:gui