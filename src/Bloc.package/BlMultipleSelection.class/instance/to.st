accessing
to
	"Return a text index of the last selected character"
	<return: #Number>

	^ ((self selections select: [ :each | each isNotEmpty ])
			detectMax: [ :each | each to ]) to