private
attributesFor: aSymbol
	"Return a collection of text or font attributes for a given style name"
	<return: #Array of: #BrTextAttribute>
	
	^ self textAttributes
		at: aSymbol
		ifAbsent: [ #() ]