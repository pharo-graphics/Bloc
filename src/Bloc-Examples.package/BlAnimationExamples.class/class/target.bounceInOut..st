examples
target: anElement bounceInOut: aBlAnimation
	<gtExample>
	<dependsOn: #target>
	<dependsOn: #bounceInOut>

	aBlAnimation
		target: anElement;
		delay: 500;
		start.
		
	^ anElement