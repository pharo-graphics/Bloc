examples - instance creation
pannableElement
	<gtExample>
	| aPannableElement |
	
	aPannableElement := BlPannableElement new.

	self assert: aPannableElement hasContentElement not. 

	^ aPannableElement