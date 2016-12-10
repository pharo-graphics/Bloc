children add/remove
addChild: anElement at: anIndex
	"Add anElement at an index moving other children to the right.
	anElement must not be a direct child of any other elements!
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not add nil element' ].
	self
		assert: [ anElement hasParent not ]
		description: [ 'Can not add child that is already added to another element!' ].
	self
		assert: [ anIndex between: 1 and: self childrenCount + 1 ]
		description: [ 'anIndex must be within children array bounds' ].

	"update parent"
	anElement parent: self.
	"actually add child"
	self children add: anElement at: anIndex.
	"send hook after element has been added"
	anElement notifyAddedInParent.
	"finally requesting children changed"
	self managedChildrenChanged.