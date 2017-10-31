events - custom
fireCustomEventWithCustomTarget
	<gtExample>
	| event target handler |
	
	event := self customEvent.
	target := self customEventTarget.
	handler := self customEventListener.
	
	target addEventHandler: handler.
	target dispatchEvent: event.
	
	self assert: event isConsumed.
	
	^ target