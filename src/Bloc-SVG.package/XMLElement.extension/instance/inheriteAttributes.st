*Bloc-SVG
inheriteAttributes
	self isRoot ifTrue: [ ^ self ].
	
	self parent attributeNamesAndValuesDo: [ :key :value | 
			(self shouldInheriteAttribute: key)
				ifTrue: [ self attributeAt: key ifAbsentPut: value ] ].
			
	self inheriteTransformAttribute.