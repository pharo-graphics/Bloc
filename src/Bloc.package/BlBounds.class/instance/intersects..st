testing
intersects: aRectangle 
	"Answer whether aRectangle intersects the receiver anywhere"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	aRight <= left ifTrue: [ ^ false ].
	aBottom <= top ifTrue: [ ^ false ].
	aLeft >= right ifTrue: [ ^ false ].
	aTop >= bottom ifTrue: [ ^ false ].
	^ true