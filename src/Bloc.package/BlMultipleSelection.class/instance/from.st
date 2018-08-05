accessing
from
	"Return a text index of the first selected character"
	<return: #Number>

	^ ((self selections select: [ :each | each isNotEmpty ])
		detectMin: [ :each | each from ]) from