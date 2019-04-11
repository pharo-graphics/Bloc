Class {
	#name : #BlTaskExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Tasks'
}

{ #category : #adding }
BlTaskExamples >> addElementWithTaskToSpace [
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
]

{ #category : #adding }
BlTaskExamples >> addTaskToTheElementWithoutSpace [
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
]

{ #category : #adding }
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
