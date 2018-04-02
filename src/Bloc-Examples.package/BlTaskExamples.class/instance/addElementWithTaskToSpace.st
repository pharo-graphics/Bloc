adding
addElementWithTaskToSpace
	<gtExample>
	| anElement aSpace |

	anElement := self addTaskToTheElementWithoutSpace.
	
	aSpace := BlSpace new.
	
	aSpace root addChild: anElement.
	
	"task were moved to the space"
	self assert: anElement taskQueue tasks isEmpty.
	self assert: aSpace taskQueue tasks size equals: 1.

	"it was not executed yet"
	self assert: aSpace taskQueue tasks first action ~~ #done. 

	^ aSpace