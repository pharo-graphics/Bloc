private
groupOf: aSpecLoader
	"Return a requested group to load. It may be prefixed with file: or git:"
	<return: #Symbol>

	^ (aSpecLoader spec required difference: aSpecLoader spec packages keys) asArray first asSymbol