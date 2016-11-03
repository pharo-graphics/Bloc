*Bloc-Athens-drawing
buildPathOnAthensBuilder: aPathBuilder
	aPathBuilder
		absolute;
		moveTo: (self transform globalPointToLocal: self from);
		lineTo: (self transform globalPointToLocal: self to)