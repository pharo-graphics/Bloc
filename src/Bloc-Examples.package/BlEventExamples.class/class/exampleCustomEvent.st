examples
exampleCustomEvent
	<example>
	| event source handler |
	
	event := BlExampleCustomEvent new payload: 'Hello world!'.
	source := BlExampleCustomEventSource new.
	handler := BlEventHandler
		on: BlExampleCustomEvent
		do: [ :aCustomEvent | self inform: aCustomEvent payload printString ].
	
	source addEventHandler: handler.
	source fireEvent: event