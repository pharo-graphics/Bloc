as yet unclassified
createSimpleSelector: anItem
	| theSelector |
	theSelector := BlStyleSimpleSelector new
		name: anItem first first;
		id: anItem first second;
		yourself.
	theSelector styleClasses addAll: anItem first third.
	theSelector pseudoClasses addAll: anItem second.
	^ theSelector
		update;
		yourself