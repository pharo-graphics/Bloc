geometry
weightedDistance: aMajorAxisDistance and: aMinorAxisDistance
	"Compute and return a resulting weighted final distance according to
	the distance along major and minor axes.
	Note: In order to make major axis to have more influence on the final result
	we introduce a so called 'fudge-factor' to get fine tuned results
	https://en.wikipedia.org/wiki/Fudge_factor"
	<return: #Number>
	
	^ (13 * aMajorAxisDistance * aMajorAxisDistance) + (aMinorAxisDistance * aMinorAxisDistance)