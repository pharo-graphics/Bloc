translation
translateBy: aDelta
	"Apply a translation by the given delta.
	Note: aDelta may be a Point, a BlPoint3D, aNumber or a BlockClosure that returns
	one of the supported types.
	In case of unknown type I thrown an Error.
	Q: why not to dispatch? A: it would pollute a Kernel with extention methods... we already added isPoint2D and isPoint3D..."

	aDelta isPoint
		ifTrue: [ aDelta isPoint2D
			ifTrue: [ self translateX: aDelta x Y: aDelta y Z: 0.0 ]
			ifFalse: [ aDelta isPoint3D
				ifTrue: [ self translateX: aDelta x Y: aDelta y Z: aDelta z ]
				ifFalse: [ self error: 'Unsupported Point type: ', aDelta asString ] ] ]
		ifFalse: [ aDelta isNumber
			ifTrue: [ self translateX: aDelta Y: aDelta Z: aDelta ]
			ifFalse: [ aDelta isBlock 
				ifTrue: [ self translateBy: aDelta value ]
				ifFalse: [ self error: 'Unsupported delta type: ', aDelta asString ] ] ]