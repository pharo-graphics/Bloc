examples
floatingCells
	| aSpace |
	<script: 'self floatingCells'>

	aSpace := BlSpace new.
	aSpace root addChild: self new floatingCells.
	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show