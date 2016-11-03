children add/remove
addChildren: aListOfElements
	"Add elements from aListOfElements as my rearmost(last) direct children and
	request layout update.
	aListOfElements must not be nil.
	all elements from aListOfElements must not be added to any other element
	@see BlElement>>#addChild: for more documentation"
	self assert: aListOfElements isNotNil.
	
	"fast exit if there are no elements to add"
	aListOfElements ifEmpty: [ ^ self ].
	"update parents"
	aListOfElements do: [ :anElement | 
			anElement parent ifNotNil: [ :p | p removeChild: anElement ].
			anElement parent: self ].
	"actually add children"	
	self children addAll: aListOfElements.
	"send hook after elements have been added"
	aListOfElements do: #notifyAddedInParent.
	"finally requesting children changed"
	self managedChildrenChanged