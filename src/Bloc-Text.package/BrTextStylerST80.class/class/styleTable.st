accessing
styleTable
	"Return a style table used by default by all stylers"
	<return: #Array>

	^ styleTable ifNil: [ styleTable := self defaultStyleTable ]