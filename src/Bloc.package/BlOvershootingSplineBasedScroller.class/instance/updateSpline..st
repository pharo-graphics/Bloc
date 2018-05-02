private - updating
updateSpline: aDeltaTime
	| aTime anIndex aDistanceCoef aVelocityCoef |
	
	aTime := aDeltaTime / self splineDuration.
	anIndex := (NbSamples * aTime) asInteger.
	aVelocityCoef := 0.0.
	aDistanceCoef := 1.0.
	
	anIndex < NbSamples
		ifTrue: [
			| tInf tSup dInf dSup |
			tInf := anIndex / NbSamples.
			tSup := (anIndex + 1) / NbSamples.
			dInf := SplinePosition at: anIndex + 1.
			dSup := SplinePosition at: anIndex + 2.
			aVelocityCoef := (dSup - dInf) / (tSup - tInf).
			aDistanceCoef := dInf + ((aTime - tInf) * aVelocityCoef) ].

	self currentVelocity: (aVelocityCoef * splineDistance / self splineDuration asMilliSeconds) * 1000.0.

	^ aDistanceCoef * splineDistance