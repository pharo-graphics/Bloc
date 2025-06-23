Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyTo: aeCanvas element: aBlElement [
	"Set up the path of my background. Afterwards, the canvas may use the same path draw the border, either if outskirts are centered, or if I don't provide an explicit setup for my border path. 
	
	See `BlElementGeometry>>#aeApplyWithInsideBorderTo:element:borderWidth:` and `BlElementGeometry>>#aeApplyWithOutsideBorderTo:element:borderWidth:`."
	
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [
	"Set up the path of my border with inside outskirts.

	A geometry has two main options:
	- Send `borderPathFactory:` to the canvas and specify a custom way to draw the border.
	- Do nothing, in which case the canvas will use the background path to emulate the indicated outskirts. 

	The second option should be slower than specifying a border path."

]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeApplyWithOutsideBorderTo: anAeCanvas element: aBlElement borderWidth: aWidth [
	"Set up the path of my border with outside outskirts. 

	A geometry has two main options:
	- Send `borderPathFactory:` to the canvas and specify a custom way to draw the border.
	- Do nothing, in which case the canvas will use the background path to emulate the indicated outskirts. 

	The second option should be slower than specifying a border path."

]

{ #category : #'*Bloc-Alexandrie' }
BlElementGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [ 
	
	aBlGradientShadowEffect setUpRectangleExtent: aPoint
]
