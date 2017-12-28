private
createMorphFor: aSpace
	| aMorph |

	aMorph := BlMorphicSpaceMorph new.
	aMorph color: Color transparent.
	aMorph extent: aSpace extent.

	^ aMorph