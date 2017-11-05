instance creation
translate: aVector
	"Create a translation transformation by a given vector"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder translateBy: aVector ];
		yourself