transformations
inherit
	"Append existing element's transformations to the new transformation list"
	
	element transformation transformation
		do: [ :aTransformation | transformation addTransformation: aTransformation ]