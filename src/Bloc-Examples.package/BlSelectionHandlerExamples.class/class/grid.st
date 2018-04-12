examples
grid
	<script: 'self grid'>
	| space element |
	
	element := self new containerWithOneGridAndVisualHandler.
	
	space := BlSpace new.
	space extent: 800@600.
	space root addChild: element.
	space show