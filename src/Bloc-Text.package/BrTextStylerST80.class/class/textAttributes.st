accessing
textAttributes
	"Return a dictionary of text attributes as assocciations of style name and an array of attributes"
	<return: #Dictionary>

	^ textAttributes ifNil: [ textAttributes := self initialTextAttributes ]