examples
gridRow
	<script: 'self gridRow'>
	| space element |
	
	element := self new containerWithThreeGridsAndVisualHandler.
	
	space := BlSpace new.
	space extent: 955@600.
	space root addChild: element.
	space show