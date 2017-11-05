instance creation
rotate: anAngleInDegrees
	"Create a rotation transformation by a given angle in degrees"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder rotateBy: anAngleInDegrees ];
		yourself