"
I have been automatically converted and probably manually tweaked from BlEventDispatcherExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlEventDispatcherTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Events'
}

{ #category : #tests }
BlEventDispatcherTest >> newDirectDispatcher [

	^ BlDirectEventDispatcher on: BlElement new
]

{ #category : #tests }
BlEventDispatcherTest >> testFilteredEventIsNotHandled [
	"Test with filter added before the handler"

	| aDispatcher wasHandled |
	wasHandled := false.

	aDispatcher := self newDirectDispatcher.
	aDispatcher
		addEventFilter: (BlEventFilter on: BlMouseDownEvent);
		addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ wasHandled := true ]).

	aDispatcher dispatchEvent: BlMouseDownEvent primary.

	self deny: wasHandled
]

{ #category : #tests }
BlEventDispatcherTest >> testFilteredEventIsNotHandled2 [
	"Test with filter added after the handler"

	| aDispatcher wasHandled |
	wasHandled := false.

	aDispatcher := self newDirectDispatcher.
	aDispatcher
		addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ wasHandled := true ]);
		addEventFilter: (BlEventFilter on: BlMouseDownEvent).

	aDispatcher dispatchEvent: BlMouseDownEvent primary.

	self deny: wasHandled
]

{ #category : #tests }
BlEventDispatcherTest >> testNonFilteredEventIsHandled [

	| aDispatcher wasHandled |
	wasHandled := false.

	aDispatcher := self newDirectDispatcher.
	aDispatcher
		addEventFilter: (BlEventFilter on: BlMouseDownEvent);
		addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ wasHandled := true ]).

	aDispatcher dispatchEvent: BlMouseUpEvent primary.
	
	self assert: wasHandled
]
