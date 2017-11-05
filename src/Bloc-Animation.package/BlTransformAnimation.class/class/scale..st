instance creation
scale: aVector
	"Create a scaling transformation by a given factor defined by a vector"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder scaleBy: aVector ];
		yourself