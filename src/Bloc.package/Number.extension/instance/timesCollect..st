*Bloc
timesCollect: aBlock
	^ (1 to: self) collect: [ :anIndex | aBlock cull: anIndex ]