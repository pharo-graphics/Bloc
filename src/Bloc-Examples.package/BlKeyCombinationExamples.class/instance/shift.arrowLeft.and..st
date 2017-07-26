examples
shift: aShiftAlternative arrowLeft: anArrowLeft and: aCompulsoryCombination
	<gtExample>
	<dependsOn: #shift:left:right:>
	<dependsOn: #arrowLeft>
	<dependsOn: #compulsoryCombination>
	
	^ aCompulsoryCombination
		with: aShiftAlternative;
		key: anArrowLeft;
		yourself