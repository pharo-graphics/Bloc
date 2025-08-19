Class {
	#name : #BlOldBasicSliderHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Bloc-Sliders'
}

{ #category : #'event management' }
BlOldBasicSliderHandler >> clickEvent: anEvent [

	anEvent currentTarget sliderBarClicked: anEvent
]

{ #category : #'event management' }
BlOldBasicSliderHandler >> dragEndEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]

{ #category : #'event management' }
BlOldBasicSliderHandler >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : #'event management' }
BlOldBasicSliderHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget sliderHandlePushed: anEvent
]

{ #category : #'event management' }
BlOldBasicSliderHandler >> mouseMoveEvent: anEvent [

	anEvent currentTarget sliderHandleMoved: anEvent
]

{ #category : #'event management' }
BlOldBasicSliderHandler >> mouseUpEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]
