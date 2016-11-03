examples
exampleBasic
|sp rect|
sp := BlSpace new.
rect := (BlRectangle length: 100) asElement background: Color green.
sp root addChild: rect.

sp root 
	addEventHandlerOn:BlDragStartEvent do:[:evt| 
		evt dragboard dragView: (BlDragView on: evt gestureSource asSpartaForm)];
 	addEventHandlerOn: BlDropEvent  do:[:evt|
		evt gestureSource position: evt position - (evt gestureSource extent/2)].
sp show 