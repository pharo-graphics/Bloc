adding
addTaskToTheElementWithoutSpace
	<gtExample>
	| anElement aTask anAction |
	
	anElement := BlElement new.
	aTask := BlTaskAction new.
	
	anAction := [ aTask action: #done ].
	aTask action: anAction.
	
	anElement enqueueTask: aTask.
	
	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: { aTask }.
	"it was not executed"
	self assert: aTask action equals: anAction. 
	
	^ anElement