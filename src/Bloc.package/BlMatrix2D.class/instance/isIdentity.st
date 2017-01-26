testing
isIdentity
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>

	^ sx = 1.0 and: [
		shy = 0.0 and: [
			shx = 0.0 and: [
				sy = 1.0 and: [
					x = 0.0 and: [
						y = 0.0 ] ] ] ] ]