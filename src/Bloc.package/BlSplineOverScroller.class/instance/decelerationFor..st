private - physics
decelerationFor: aVelocity
	"Return a signed deceleration that will reduce the velocity"
	<return: #Number>

	^ aVelocity > 0
		ifTrue: [ Gravity negated ]
		ifFalse: [ Gravity ]