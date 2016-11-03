initialization
initializeFor: aCollectionOfFloatingChildren maxLength: aNumber
	"By definition floating elements can not overlap"
	| endOfOccupiedSpace |
	aCollectionOfFloatingChildren ifEmpty: [ 
		intervals := { 0 to: aNumber }.
		^ self ].
	
	intervals := OrderedCollection new.
	endOfOccupiedSpace := aCollectionOfFloatingChildren inject: 0 into: [ :aStart :aChild |
			aStart = aChild startLength
				ifFalse: [ intervals add: (aStart to: aChild startLength) ].
			aChild startLength + aChild totalLength ].
	
	intervals add: (endOfOccupiedSpace to: aNumber)