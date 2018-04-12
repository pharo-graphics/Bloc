accessing
allSelections
	"Return a collection of all monotone selection intervals within this selection"
	<return: #Collection of: #BlMonotoneSelection>
	
	^ Array streamContents: [ :aStream | self do: [ :aSelection | aStream nextPut: aSelection ] ]