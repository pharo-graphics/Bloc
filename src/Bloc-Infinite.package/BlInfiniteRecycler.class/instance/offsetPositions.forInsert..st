accessing - position
offsetPositions: aStartPosition forInsert: anItemCount

	cachedScrap
		select: [ :aHolder | aHolder position >= aStartPosition ]
		thenDo: [ :aHolder | aHolder offsetPositionBy: anItemCount applyToPreLayout: true ]