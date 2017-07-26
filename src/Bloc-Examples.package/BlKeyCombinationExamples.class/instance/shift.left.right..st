examples
shift: aKeyAlternative left: aLeftShift right: aRightShift
	<gtExample>
	<dependsOn: #alternativeCombination>
	<dependsOn: #leftShift>
	<dependsOn: #rightShift>
	
	^ aKeyAlternative
		key: aLeftShift;
		key: aRightShift;
		yourself