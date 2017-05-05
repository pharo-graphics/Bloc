testing
isPureTranslation
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
	^ scaleX = 1.0 and: [
		scaleY = 1.0 and: [
			scaleZ = 1.0 and: [
				rotateAngle = 0.0 ] ] ] 