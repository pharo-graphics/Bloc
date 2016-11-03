as yet unclassified
surfaceForSpace: aSpace
	(session = Smalltalk session and: [ surface notNil and: [ surface extent = aSpace contentExtent ] ])
		ifTrue: [ ^ surface ].
	surface := (AthensCairoSurface extent: aSpace contentExtent).
	session := Smalltalk session.
	^ surface