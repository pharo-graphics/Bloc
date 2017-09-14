transformations
scaleElement: aBlElement with: anOrderedCollection
	|sx sy|
	sy := sx:= anOrderedCollection first.
	anOrderedCollection size=2 ifTrue:[ sy:= anOrderedCollection last ].
	
	aBlElement scaleBy: sx@sy.