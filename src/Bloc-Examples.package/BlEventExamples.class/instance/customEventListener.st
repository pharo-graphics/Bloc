instance creation
customEventListener
	<gtExample>
	
	^ BlEventHandler
		on: BlExampleCustomEvent
		do: [ :aCustomEvent | aCustomEvent consumed: true ]