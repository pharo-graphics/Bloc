physics
adjustDuration: aStart final: aNewFinal previousFinal: anOldFinal
	| anOldDistance aNewDistance anX anIndex anIndexPlusOne |
	
	anOldDistance := anOldFinal - aStart.
	aNewDistance := aNewFinal - aStart.
	anX := (aNewDistance / anOldDistance) asFloat abs.
	anIndex := (NbSamples * anX) asInteger.
	anIndexPlusOne := anIndex + 1.
	
	(anIndex < NbSamples)
		ifTrue: [ 
			| xInf xSup tInf tSup timeCoeff|
			xInf := (anIndex / NbSamples) asFloat.
			xSup := (anIndexPlusOne / NbSamples) asFloat.
			tInf := SplineTime at: anIndexPlusOne.
			tSup := SplineTime at: anIndexPlusOne + 1.
			timeCoeff := tInf + ( (anX - xInf) / (xSup - xInf) * (tSup - tInf) ).
			duration := duration * timeCoeff ]