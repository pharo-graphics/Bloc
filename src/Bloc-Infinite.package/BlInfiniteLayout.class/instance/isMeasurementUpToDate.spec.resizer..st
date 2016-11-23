measurement - testing
isMeasurementUpToDate: aMeasuredSize spec: aMeasurementSpec resizer: aResizer
	"Return true if measured child's size is up-to-date with measured specification and dimension"

	(aResizer isExact and: [ aMeasuredSize ~= aResizer size ])
		ifTrue: [ ^ false ].

	aMeasurementSpec isUnspecified
		ifTrue: [ ^ true ].

	aMeasurementSpec isAtMost
		ifTrue: [ ^ aMeasurementSpec size >= aMeasuredSize ].
		
	aMeasurementSpec isExact
		ifTrue: [ ^ aMeasurementSpec size = aMeasuredSize ].
		
	^ false