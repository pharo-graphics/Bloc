examples
directDispatcherWithMouseDownFilterAndHandlerWithMouseUpHandler
	<gtExample>
	| aDispatcher mouseUpHandled |

	aDispatcher := self directDispatcherWithMouseDownFilterAndHandler.

	mouseUpHandled := false.

	aDispatcher addEventHandler: (BlEventHandler on: BlMouseUpEvent do: [ mouseUpHandled := true ]).
	aDispatcher dispatchEvent: BlMouseUpEvent primary.

	self assert: mouseUpHandled.

	^ aDispatcher