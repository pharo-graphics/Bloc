private - measurement
measureIgnored: anElement with: anExtentSpec
	"Measure ignore children of a given parent allowing them to take as much space as they want"

	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
			self
				measureChild: aChild
				parentSpec: anExtentSpec ]