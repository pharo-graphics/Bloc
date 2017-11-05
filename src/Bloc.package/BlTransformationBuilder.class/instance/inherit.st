transformations
inherit
	"Append existing element's transformations to the new transformation list"
	
	target transformation transformation
		do: [ :aTransformation | transformation addTransformation: aTransformation ]