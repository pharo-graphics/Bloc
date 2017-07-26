examples
meta: aKeyAlternative left: aLeftMeta right: aRightMeta
	<gtExample>
	<dependsOn: #alternativeCombination>
	<dependsOn: #leftMeta>
	<dependsOn: #rightMeta>
	
	^ aKeyAlternative
		key: aLeftMeta;
		key: aRightMeta;
		yourself