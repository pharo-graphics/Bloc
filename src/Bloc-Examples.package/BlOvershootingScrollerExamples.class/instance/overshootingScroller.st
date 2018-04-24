examples - instance creation
overshootingScroller
	<gtExample>
	| aScroller |
	
	aScroller := BlOvershootingScroller new.
	
	self assert: aScroller isFlywheel. 
	
	^ aScroller