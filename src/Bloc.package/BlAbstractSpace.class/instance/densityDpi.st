accessing
densityDpi
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>

	self hostSpace
		ifNotNil: [ :hw | ^ hw densityDpi ].

	"Without actual window we can only guess"
	^ 96.0