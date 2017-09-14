transformations
rotateElement: aBlElement with: anOrderedCollection
	|r cx cy|
	cx:= cy:= 0.
	r:= anOrderedCollection first.
	anOrderedCollection size=3 ifTrue:[ cx:=anOrderedCollection second.
													cy:=anOrderedCollection last.].
												
	aBlElement rotateByDegrees: r center: (cx - (aBlElement position x))@(cy - (aBlElement position y)) 