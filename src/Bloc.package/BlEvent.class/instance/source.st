accessing
source
	"Return an event target that plays a role of a source of this event"
	<return: #BlEventTarget>

	self
		assert: [ self hasSource ]
		description: [ 'Can not access a source if there is no one' ].

	^ source