path building
buildPathOn: aPathBuilder
	aPathBuilder
		absolute;
		moveTo: (self transform globalPointToLocal: self from);
		lineTo: (self transform globalPointToLocal: self to)