accessing
empty
	"Return a unique empty collection rope which can be shared among all users"
	<return: #BlCollectionRope>
	
	^ empty ifNil: [ self collection: #() ]