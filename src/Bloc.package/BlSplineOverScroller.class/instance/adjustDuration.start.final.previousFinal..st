private - physics
adjustDuration: aDuration start: aStart final: aNewFinal previousFinal: anOldFinal
	<return: #Duration>
	| anOldDistance aNewDistance anX anIndex anIndexPlusOne aNewDuration |

	aNewDuration := aDuration.
	
	anOldDistance := anOldFinal - aStart.
	aNewDistance := aNewFinal - aStart.
	anX := (aNewDistance / anOldDistance) asFloat abs.
	anIndex := self truncated: (self nbSamples * anX).
	anIndexPlusOne := anIndex + 1.

	(anIndex < self nbSamples)
		ifTrue: [ 
			| xInf xSup tInf tSup timeCoeff|
			xInf := (anIndex / self nbSamples) asFloat.
			xSup := (anIndexPlusOne / self nbSamples) asFloat.
			tInf := self splineTime at: anIndexPlusOne.
			tSup := self splineTime at: anIndexPlusOne + 1.
			timeCoeff := tInf + ( (anX - xInf) / (xSup - xInf) * (tSup - tInf) ).
			"duration must not be fractional"
			aNewDuration := (self truncated: (aDuration * timeCoeff) asMilliSeconds) milliSeconds ].
		
	^ aNewDuration