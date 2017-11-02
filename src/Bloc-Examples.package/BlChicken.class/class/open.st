examples
open
	<script: 'self open'>
	| space chicken |
	
	space := BlSpace new.
	space extent: 300 @ 500.
	space title: 'Software chicken'.
	
	chicken := self chicken.
	chicken constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	space root addChild: chicken.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show