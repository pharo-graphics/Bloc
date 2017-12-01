geometry
computeOuterWidth: aNumber
	<return: #Number>
	"cathetus = (Hi / 2) * tan(alpha / 2)"

	^ (self computeOuterHeight: aNumber) / 2.0 / (self arrowNoseAngle degreesToRadians / 2.0) tan