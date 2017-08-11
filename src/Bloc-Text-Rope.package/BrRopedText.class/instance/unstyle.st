text - attributes
unstyle
	"Return a copy of a text without all attributes that are overwritable by stylers"
	<return: #BrText>
	| anUnstyledRope |

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: 1
		to: anUnstyledRope size
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].
	
	self rope: anUnstyledRope