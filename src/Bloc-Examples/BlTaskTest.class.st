"
I have been automatically converted and probably manually tweaked from BlTaskExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlTaskTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Tasks'
}

{ #category : #tests }
BlTaskTest >> testAddElementWithTaskToSpace [
	<sampleInstance>
	
	| anElement aSpace aTask |
	anElement := self testAddTaskToTheElementWithoutSpace.
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

{ #category : #tests }
BlTaskTest >> testAddTaskToTheElementWithoutSpace [

	<sampleInstance>
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

{ #category : #tests }
BlTaskTest >> testPulseSpaceWithTask [

	<sampleInstance>
	| aSpace aTask |
	aSpace := self testAddElementWithTaskToSpace.
	aTask := aSpace taskQueue tasks first.
	aSpace pulse.
	"task was run and queue is empty now"
	self assert: aSpace taskQueue tasks isEmpty.

	"action was executed"
	self assert: aTask action equals: #done.

	^ aSpace
]
