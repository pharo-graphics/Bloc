instance creation
a: aA cr: aCr1 b: aB cr: aCr2 c: aC
	<gtExample>
	<dependsOn: #a>
	<dependsOn: #cr>
	<dependsOn: #b>
	<dependsOn: #cr>
	<dependsOn: #c>
	
	^ aA, aCr1, aB, aCr2, aC