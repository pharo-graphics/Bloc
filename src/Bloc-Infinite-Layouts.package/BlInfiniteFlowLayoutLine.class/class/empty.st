requirements
empty
	"Return empty singleton line.
	Note, that empty line is marked as read only"

	^ empty ifNil: [ empty := self new; beReadOnlyObject; yourself ]