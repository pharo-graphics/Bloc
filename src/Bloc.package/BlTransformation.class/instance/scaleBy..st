scaling
scaleBy: aFactor
	"Apply a scaling by the given factor.
	Note: aDelta may be a Point, a BlPoint3D, aNumber or a BlockClosure that returns
	one of the supported types.
	In case of unknown type I thrown an Error.
	Q: why not to dispatch? A: it would pollute a Kernel with extention methods... we already added isPoint2D and isPoint3D..."

	aFactor isPoint
		ifTrue: [ aFactor isPoint2D
			ifTrue: [ self scaleX: aFactor x Y: aFactor y Z: 1.0 ]
			ifFalse: [ aFactor isPoint3D
				ifTrue: [ self scaleX: aFactor x Y: aFactor y Z: aFactor z ]
				ifFalse: [ self error: 'Unsupported Point type: ', aFactor asString ] ] ]

		"exotic cases when factor is not a point"
		ifFalse: [ aFactor isNumber
			ifTrue: [ self scaleX: aFactor Y: aFactor Z: aFactor ]
			ifFalse: [ aFactor isBlock 
				ifTrue: [ self scaleBy: aFactor value ]
				ifFalse: [ self error: 'Unsupported delta type: ', aFactor asString ] ] ]