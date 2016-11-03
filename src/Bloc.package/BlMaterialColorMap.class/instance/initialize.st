as yet unclassified
initialize
	super initialize.
	colorMap := Dictionary new.
	(Pragma allNamed: #loadColor in: self class)
		do: [ :pragma | (Message selector: pragma methodSelector) sendTo: self ]