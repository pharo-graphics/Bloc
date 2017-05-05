testing
isIdentity
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ translateX = 0.0 and: [
		translateY = 0.0 and: [
			translateZ = 0.0 and: [
				self isPureTranslation ] ]]