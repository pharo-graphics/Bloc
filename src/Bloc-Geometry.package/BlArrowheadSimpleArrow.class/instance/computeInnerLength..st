geometry
computeInnerLength: aNumber
	<return: #Number>
	"hypotenuse = (Hi / 2) * cos(alpha / 2)"

	^ (self computeInnerHeight: aNumber) / 2.0 / (self arrowNoseAngle degreesToRadians / 2.0) cos