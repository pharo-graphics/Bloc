as yet unclassified
convertKeyModifiersFromModState: modState 
	| shift ctrl alt gui |
	shift := (modState bitAnd: GdkModifierType GDK_SHIFT_MASK value) ~= 0.
	ctrl := (modState bitAnd: GdkModifierType GDK_CONTROL_MASK value) ~= 0.
	alt := (modState bitAnd: GdkModifierType GDK_MOD1_MASK value) ~= 0.
	gui := (modState bitAnd: GdkModifierType GDK_META_MASK value) ~= 0.
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd:gui