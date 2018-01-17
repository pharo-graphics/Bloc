examples
directDispatcherWithMouseDownFilter
	<gtExample>
	| aDispatcher |
	
	aDispatcher := self directDispatcher.
	aDispatcher addEventFilter: (BlEventFilter on: BlMouseDownEvent).

	^ aDispatcher