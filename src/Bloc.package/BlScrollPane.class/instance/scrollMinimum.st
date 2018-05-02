api - scrolling geometry
scrollMinimum
	<return: #Point>
	
	^ (self extent - self contentElement extent) min: 0@0