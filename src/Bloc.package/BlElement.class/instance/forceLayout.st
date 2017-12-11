layout utilities
forceLayout
	"Do not use me, I am a private / debug utility method to force layout computation.
	The main usage of this method is for testing purposes where we want to update layout
	without the need to create a separate space and add an element to it in order to test bounds or position.
	Note: because layout measurement may depend on other element it is mandatory to compute
	layout going down from the top most parent, otherwise layout will not be valid"

	self topMostParent == self
		ifTrue: [ self computeLayout ]
		ifFalse: [ self topMostParent computeLayout ]