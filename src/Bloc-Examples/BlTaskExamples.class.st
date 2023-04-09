Class {
	#name : #BlTaskExamples,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Examples-Tasks'
}

{ #category : #'adding - single task' }
BlTaskExamples >> addElementWithTaskToSpace [
	<gtExample>
	| anElement aSpace aTask |

	anElement := self addTaskToTheElementWithoutSpace.
	
	aSpace := BlSpace new.
	
	aSpace root addChild: anElement.
	
	"task were moved to the space"
	self assert: anElement taskQueue tasks isEmpty.
	self assert: aSpace taskQueue tasks size equals: 1.

	"it was not executed yet"
	aTask := aSpace taskQueue tasks first.
	self assert: aTask action ~~ #done.
	self assert: aTask isQueued.

	^ aSpace
]

{ #category : #'adding - single task' }
BlTaskExamples >> addTaskToTheElementWithoutSpace [
	<gtExample>
	| anElement aTask anAction |
	
	anElement := BlElement new.
	aTask := BlTaskAction new.
	self assert: aTask isNew.

	anAction := [ aTask action: #done ].
	aTask action: anAction.
	
	anElement enqueueTask: aTask.
	
	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: { aTask }.
	"it was not executed"
	self assert: aTask action equals: anAction. 
	self assert: aTask isQueued.

	^ anElement
]

{ #category : #'adding - single task' }
BlTaskExamples >> pulseSpaceWithTask [
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
]
