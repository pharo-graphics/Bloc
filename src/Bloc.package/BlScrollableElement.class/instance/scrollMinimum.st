api - scrolling geometry
scrollMinimum
	<return: #Point>
	
	^ (self extent - self scrolledElement extent) min: 0@0