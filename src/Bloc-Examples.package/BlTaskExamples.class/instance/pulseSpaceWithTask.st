adding
pulseSpaceWithTask
	<gtExample>
	| aSpace aTask |

	aSpace := self addElementWithTaskToSpace.
	
	aTask := aSpace taskQueue tasks first.
	
	aSpace pulse.
	
	"task was run and queue is empty now"
	self assert: aSpace taskQueue tasks isEmpty.

	"action was executed"
	self assert: aTask action equals: #done. 

	^ aSpace