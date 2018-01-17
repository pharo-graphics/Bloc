instance creation
mouseProcessor
	| aMouseProcessor aSpace |
	<gtExample>
	
	aSpace := BlSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.
	
	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor