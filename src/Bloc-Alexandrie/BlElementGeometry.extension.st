Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyTo: aeCanvas element: aBlElement [
	"Establish the path on the canvas to draw my background and/or border (the element properties determine what's necessary)."
	
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [
	"Set up the path of my border with inside outskirts.

	A geometry has two main options:
	- Send `borderPathFactory:` the canvas and specify a custom way to draw the border.
	- Do nothing, in which case the canvas will use the background path to emulate the indicated outskirts. 

	The second option should be slower than specifying a border path."

]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithOutsideBorderTo: anAeCanvas element: aBlElement borderWidth: aWidth [
	"Set up the path of my border with outside outskirts. 

	A geometry has two main options:
	- Send `borderPathFactory:` the canvas and specify a custom way to draw the border.
	- Do nothing, in which case the canvas will use the background path to emulate the indicated outskirts. 

	The second option should be slower than specifying a border path."

]
