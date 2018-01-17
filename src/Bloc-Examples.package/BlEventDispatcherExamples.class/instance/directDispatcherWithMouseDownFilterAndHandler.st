examples
directDispatcherWithMouseDownFilterAndHandler
	<gtExample>
	| aDispatcher mouseDownHandled |
	
	aDispatcher := self directDispatcherWithMouseDownFilter.

	mouseDownHandled := false.

	aDispatcher addEventHandler: (BlEventHandler on: BlMouseDownEvent do: [ mouseDownHandled := true ]).
	aDispatcher dispatchEvent: BlMouseDownEvent primary.

	self assert: mouseDownHandled not.

	^ aDispatcher