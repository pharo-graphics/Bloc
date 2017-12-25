show / close
spaceShown
	<gtExample>
	| aSpace spaceShown |
	spaceShown := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceShownEvent do: [ spaceShown := spaceShown + 1 ].

	aSpace show.
	self assert: spaceShown equals: 1.
	
	^ aSpace