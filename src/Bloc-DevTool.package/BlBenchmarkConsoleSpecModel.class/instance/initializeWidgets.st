as yet unclassified
initializeWidgets
	self title: 'Bloc Dev Tool'.
	fpsLabel := self newLabel label:'FPS (frame/s):'.
	layoutTimeLabel := self newLabel label:'LAYOUT PROCESSING (ms):'.
	renderTimeLabel := self newLabel label:'RENDER PROCESSING (ms):'.
	eventTimeLabel := self newLabel label:'EVENT PROCESSING (ms):'.
	
	fps := self newLabel.
	layoutTime := self newLabel.
	renderTime := self newLabel.
	eventTime := self newLabel.