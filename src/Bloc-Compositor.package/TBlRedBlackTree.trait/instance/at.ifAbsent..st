tree - searching
at: aComparable ifAbsent: aBlock 
	"Answer the property value or pragma associated with aKey or,
	 if aKey isn't found, answer the result of evaluating aBlock."

	^ self
		at: aComparable
		ifPresent: #yourself
		ifAbsent: [ aBlock value ]