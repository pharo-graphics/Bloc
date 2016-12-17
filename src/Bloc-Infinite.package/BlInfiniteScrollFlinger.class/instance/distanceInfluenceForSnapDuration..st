physics
distanceInfluenceForSnapDuration: aFactorNumber
	<return: #Number>
	| f |

	f := aFactorNumber - 0.5. "center the values about 0"
	f := f * 0.3 * Float pi / 2.0.
	^ f sin