accessing
managed: aBoolean
	"If false is provided, then the element is not subject to the parent's layout"
	
	(misc managed = aBoolean) ifTrue: [ ^ self ].
	misc managed: aBoolean.
	self parent ifNotNil: [ :p | p managedChildrenChanged ]