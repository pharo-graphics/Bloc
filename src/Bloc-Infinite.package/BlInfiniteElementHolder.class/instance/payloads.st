accessing - payload
payloads
	"I return un-modifiable list of paylods taking update request into account"
	<return: #Array>

	^ self flags hasDataSourceFullUpdate
		ifFalse: [ 
			payloads
				"Initial state, no update being requested"
				ifEmpty: [ #() ]
				ifNotEmpty: [ payloads ] ]
			"a full update has been requested"
		ifTrue: [ #() ]