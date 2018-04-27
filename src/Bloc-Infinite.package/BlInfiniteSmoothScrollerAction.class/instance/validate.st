private
validate
	"I am a class invariant"
	(interpolator isNotNil and: [ duration <= 0 seconds ])
		ifTrue: [ 
			self error: 'If you provide an interpolator you must set a positive duration' ]
		ifFalse: [ 
			duration <= 0 seconds
				ifTrue: [ self error: 'Scroll duration must be a positive number' ] ]