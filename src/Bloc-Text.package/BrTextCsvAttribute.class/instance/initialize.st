initialization
initialize
	super initialize.
	formBlock := [ :anUrl | | csv splitted header children composite morph |
	csv := (self url ifNil:  [ anUrl ]) asString asZnUrl retrieveContents.
	splitted := csv splitOn: (String cr , '|' , String lf) asRegex.
	header := splitted first.
	children := splitted allButFirst allButLast.
	composite := GLMCompositePresentation new.
	composite table
		display: [ children ];
		column: [ (header splitOn: ',') first capitalized ]
			evaluated: [ :aString | (aString splitOn: ',') first ]
			width: 120;
		column: [ (header splitOn: ',') second capitalized ]
			evaluated: [ :aString | (aString splitOn: ',') second ].
	composite presentations last title: nil.
	composite startOn: children.
	morph := composite renderGlamorouslyOn: GLMRenderer subclasses first new.
	morph extent: self extent.
	morph imageForm ]