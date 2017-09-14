*Bloc-SVG
at: anIndex ifPresent: aBlock
	collection at: anIndex ifAbsent: [ ^self ].
	^aBlock