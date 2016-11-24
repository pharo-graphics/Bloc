examples
exampleCustomEvent
	<example>
	| event target handler |
	
	event := BlExampleCustomEvent new payload: 'Hello world!'.
	target := BlExampleCustomEventTarget new.
	handler := BlEventHandler
		on: BlExampleCustomEvent
		do: [ :aCustomEvent | self inform: aCustomEvent payload printString ].
	
	target addEventHandler: handler.
	target fireEvent: event