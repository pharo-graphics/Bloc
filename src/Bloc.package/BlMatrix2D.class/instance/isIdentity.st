testing
isIdentity
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>

	^ a11 = 1.0 and: [
		a12 = 0.0 and: [
			a21 = 0.0 and: [
				a22 = 1.0 and: [
					a31 = 0.0 and: [
						a32 = 0.0 ] ] ] ] ]