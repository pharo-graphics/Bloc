attributes
mergeAttributes: aCollectionOfAttributes and: anotherCollectionOfAttributes
	"Merge two collection of attributes letting anotherCollectionOfAttributes to override
	attributes from aCollectionOfAttributes based on its type"
	<return: #Set>
	| aSet |
	
	"using pluggable set with custom hash function allows us to reduce amount of memory
	allocations since we just create one set collection"
	aSet := (PluggableSet new: aCollectionOfAttributes size + anotherCollectionOfAttributes size)
		hashBlock: [ :anAttribute | anAttribute class hash ];
		equalBlock: [ :a :b | a class = b class ].
		
	aSet addAll: anotherCollectionOfAttributes.
	aSet addAll: aCollectionOfAttributes.
	
	aSet
		hashBlock: [ :anAttribute | anAttribute hash ];
		equalBlock: [ :a :b | a = b ].
	
	aSet rehash.
	
	^ aSet