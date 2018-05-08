examples - instance creation
scrollPaneWithContentInSpace
	<gtExample>
	| aSpace aScrollPane |
	
	aScrollPane := self scrollPaneWithContent.
	
	aSpace := self spaceWithSumulatedTime.
	aSpace root addChild: aScrollPane.
	
	aSpace pulse.
	
	self assert: aScrollPane extent equals: self scrollPaneExtent.
	self assert: aScrollPane position equals: 0@0.
	
	self assert: aScrollPane scrolledElement extent equals: self contentExtent.
	self assert: aScrollPane scrolledElement position equals: 0@0.
	
	self assert: aScrollPane scrollPosition equals: 0@0.
	self assert: aScrollPane scrollOvershot equals: (self scrollPaneExtent / 2.0).
	self assert: aScrollPane scrollMinimum equals: (self scrollPaneExtent - self contentExtent).
	self assert: aScrollPane scrollMaximum equals: (0@0).
	
	self assert: aScrollPane canScrollHorizontally.
	self assert: aScrollPane canScrollVertically.

	^ aScrollPane