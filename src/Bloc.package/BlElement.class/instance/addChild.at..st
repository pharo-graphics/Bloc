children add/remove
addChild: anElement at: anIndex
	"Add anElement at an index moving other children to the right.
	anElement must not be a direct child of any other element!
	anElement must not be nil
	anIndex must be greater or equal to 1 and less or equal than amount of existing children + 1"
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
	"dispatch events/hooks after element has been added"
	self dispatchChildAdded: anElement.
	"mt managed children changed, request invalidation"
	self managedChildrenChanged.
	"We should request layout from newly added element to mark it as dirty too"
	anElement requestLayout.