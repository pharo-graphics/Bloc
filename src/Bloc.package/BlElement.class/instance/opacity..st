accessing
opacity: aNumber
	"Set my opacity and request invalidation. Opacity is a visual property independent
	from visibility, which also influences layout and event handling. Transparent elements
	with opacity set to 0 still can receive and handle events.

	If you want to make element invisible and prevent it from handle events, change its
	visibility to ==element visibility: BlVisibility hidden==.
	
	Opacity is represented by a number within range [0...1] and should be a float.
	Note: a given number will be clamped to be within defined range,
	so if aNumber is -1 opacity will be 0 and the same way if opacity
	is requested to be 2 it will infact become 1.
	aNumber must not be nil"

	self
		assert: [ aNumber isNotNil ]
		description: [ 'Opacity can not be nil' ].

	opacity := (aNumber asFloat max: 0.0) min: 1.0.
	
	"If opacity is very close to zero, element actually should be completely
	transparent, and the other way around, if opacity is almost 1
	we can treat element as completely opaque.
	Implementation detail: #reduce has too high precision for our needs"
	(opacity closeTo: 0.0 precision: 0.001) ifTrue: [ opacity := 0.0 ].
	(opacity closeTo: 1.0 precision: 0.001) ifTrue: [ opacity := 1.0 ].

	self invalidate