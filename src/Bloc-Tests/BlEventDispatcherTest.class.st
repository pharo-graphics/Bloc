"
I have been automatically converted and probably manually tweaked from BlEventDispatcherExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlEventDispatcherTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #tests }
BlEventDispatcherTest >> testDirectDispatcher [

	<sampleInstance>
	^ BlDirectEventDispatcher on: BlElement new
]

{ #category : #tests }
BlEventDispatcherTest >> testDirectDispatcherWithMouseDownFilter [

	<sampleInstance>
	| aDispatcher |
	aDispatcher := self testDirectDispatcher.
	aDispatcher addEventFilter: (BlEventFilter on: BlMouseDownEvent).

	^ aDispatcher
]

{ #category : #tests }
BlEventDispatcherTest >> testDirectDispatcherWithMouseDownFilterAndHandler [

	<sampleInstance>
	| aDispatcher mouseDownHandled |
	aDispatcher := self testDirectDispatcherWithMouseDownFilter.

	mouseDownHandled := false.

	aDispatcher addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ mouseDownHandled := true ]).
	aDispatcher dispatchEvent: BlMouseDownEvent primary.

	self assert: mouseDownHandled not.

	^ aDispatcher
]

{ #category : #tests }
BlEventDispatcherTest >> testDirectDispatcherWithMouseDownFilterAndHandlerWithMouseUpHandler [

	<sampleInstance>
	| aDispatcher mouseUpHandled |
	aDispatcher := self testDirectDispatcherWithMouseDownFilterAndHandler.

	mouseUpHandled := false.

	aDispatcher addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ mouseUpHandled := true ]).
	aDispatcher dispatchEvent: BlMouseUpEvent primary.

	self assert: mouseUpHandled.

	^ aDispatcher
]
