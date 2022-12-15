Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyTo: aeCanvas element: aBlElement [
	"Establish the path on the canvas to draw my background and/or border (the element properties determine what's necessary)."
	
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [
	"Establish the paths on the canvas, that it can use to draw my background and border, if necessary (if the element properties make it necessary).
	
	The general implementation ignores the outskirt (at this point), specifying to the canvas only the background path. The canvas knows how to use such path to draw the border with inside outskirts, but it should be slower than specifying a border path, if possible by each concrete geometry (my subclasses)."

	self aeApplyTo: aeCanvas element: aBlElement
]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithOutsideBorderTo: anAeCanvas element: aBlElement borderWidth: aWidth [
	"Establish the paths on the canvas, that it can use to draw my background and border, if necessary (if the element properties make it necessary).
	
	The general implementation ignores the outskirt (at this point), specifying to the canvas only the background path. The canvas knows how to use such path to draw the border with outside outskirts, but it should be slower than specifying a border path, if possible by each concrete geometry (my subclasses)."

	self aeApplyTo: anAeCanvas element: aBlElement
]
