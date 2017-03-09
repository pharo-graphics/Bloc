text - attributes
unstyle
	"Return a copy of a text without any style attributes"
	<return: #BrText>
	| anUnstyledRope |

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: 1
		to: anUnstyledRope size
		if: [ :anAttribute | anAttribute isStyle ].
	
	self rope: anUnstyledRope