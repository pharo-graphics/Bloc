accessing - position
offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount

	cachedScrap
		select: [ :aHolder | aHolder position >= aStartPosition ]
		thenDo: [ :aHolder | aHolder offsetPositionBy: anItemCount applyToPreLayout: true ]