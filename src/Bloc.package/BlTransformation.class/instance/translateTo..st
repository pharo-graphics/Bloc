translation
translateTo: aPoint
	"Define the coordinates of the translation using the given point.
	Note: aPoint may be a Point, a BlPoint3D or a BlockClosure that returns 
	one of the supported types."

	aPoint isPoint
		ifTrue: [ aPoint isPoint2D
			ifTrue: [ 
				self ensure2D.
				matrix2D setTranslateX: aPoint x Y: aPoint y ]
			ifFalse: [ aPoint isPoint3D
				ifTrue: [ 
					self ensure3D.
					matrix3D setTranslateX: aPoint x Y: aPoint y Z: aPoint z ]
				ifFalse: [ self error: 'Unsupported Point type: ', aPoint asString ] ] ]
		ifFalse: [ aPoint isBlock 
			ifTrue: [ self translateTo: aPoint value ]
			ifFalse: [ self error: 'Unsupported delta type: ', aPoint asString ] ] 