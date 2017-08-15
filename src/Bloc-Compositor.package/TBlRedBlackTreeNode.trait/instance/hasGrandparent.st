tree - testing
hasGrandparent
	"Return true if I have a grandparent, false otherwise"
	<return: #Boolean>
	
	^ self hasParent and: [ self parent hasParent ]