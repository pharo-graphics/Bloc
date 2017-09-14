*Bloc-SVG
angleBetweenVector: u andVector: v
	| sign scalarProduct acos |
	
	sign := (u x)*(v y)-((u y)*(v x)) sign.
	
	scalarProduct := (u x)*(v x)+((u y)*(v y)).
	acos :=  (scalarProduct / ((u dist:0@0) * (v dist:0@0))) arcCos.
	
	^ sign*acos