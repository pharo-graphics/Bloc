tree - searching
at: aComparable 
	"Answer the value associated with the key."

	^ self at: aComparable ifAbsent: [ self errorKeyNotFound: aComparable ]