show / close
spaceClosed
	<gtExample>
	| aSpace spaceClosed |
	spaceClosed := 0.
	
	aSpace := self spaceShown.
	aSpace addEventHandlerOn: BlSpaceClosedEvent do: [ spaceClosed := spaceClosed + 1 ].

	aSpace close.
	self assert: spaceClosed equals: 1.
	
	^ aSpace