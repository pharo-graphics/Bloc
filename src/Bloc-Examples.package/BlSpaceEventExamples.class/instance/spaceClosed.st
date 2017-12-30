show / close
spaceClosed
	<gtExample>
	| aSpace spaceClosed |
	spaceClosed := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceClosedEvent do: [ spaceClosed := spaceClosed + 1 ].
	
	aSpace show.
	self assert: spaceClosed equals: 0.
	aSpace close.
	self assert: spaceClosed equals: 1.
	
	^ aSpace