adding
removeSpace: aSpace
	(spaces includes: aSpace) ifFalse:[^ self].
	spaces remove: aSpace