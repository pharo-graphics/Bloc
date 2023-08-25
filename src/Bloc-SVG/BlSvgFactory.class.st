"
I am a factory. My input is a XMLElement coming from a SVG file, my output is a BlElement matchingthe input.
I am used to translate an graphical object from SVG to Bloc.

My instance variable 'definitions' is a Dictionary used to store previously created objects when they have a 'id' attribute, so that they may be re-used in the same SVG file.

Main example of use:
    - BlSVGFactory new generateElementFrom: anXMLElement.

Process explained:
    - the 'generateElementFrom:' method acts as a switch calling the appropriate method in regard to the XMLElement to translate;
    - this called method generates the appropriate BlGeometry with the appropriate parameters, then convert the BlGeometry to a BlElement;
    - the called method sets some specific properties on the BlElement, then calls (in most cases) 'allPropertiesFrom:on:' to set the 'rendering properties' and 'common properties' shared by most objects.
"
Class {
	#name : #BlSvgFactory,
	#superclass : #Object,
	#instVars : [
		'classes',
		'definitions'
	],
	#category : #'Bloc-SVG-Converter'
}

{ #category : #properties }
BlSvgFactory >> allPropertiesFrom: attributes on: aBlElement [

	self renderingPropertiesFrom: attributes on: aBlElement.
	self commonPropertiesFrom: attributes on: aBlElement
]

{ #category : #definitions }
BlSvgFactory >> altGlyphDefFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #'circle & ellipse' }
BlSvgFactory >> circleFrom: node [

	node attributeAt: 'rx' put: (node attributeAt: 'r').
	node attributeAt: 'ry' put: (node attributeAt: 'r').
	^ self ellipseFrom: node
]

{ #category : #definitions }
BlSvgFactory >> clipPathFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #properties }
BlSvgFactory >> commonPropertiesFrom: attributes on: aBlElement [

	aBlElement outskirts: BlOutskirts centered.
	aBlElement layout: BlSvgGroupLayout new.

	attributes
		at: 'display'
		ifPresent: [ self displayPropertyFrom: attributes on: aBlElement ].

	attributes at: 'id' ifPresent: [ 
self flag: #todo. "		aBlElement svgName: (attributes at: 'id')."
		self idHandlingFrom: attributes on: aBlElement ]
]

{ #category : #definitions }
BlSvgFactory >> cursorFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #definitions }
BlSvgFactory >> definitions [

	^ definitions
]

{ #category : #definitions }
BlSvgFactory >> defsFrom: node [
	"Behaves like a 'g' but won't be added to any parent because always contains references, see 'XMLElement >> translatedBy:withParent:' "

	^ self gFrom: node
]

{ #category : #metadata }
BlSvgFactory >> descFrom: attributes [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #properties }
BlSvgFactory >> displayPropertyFrom: attributes on: aBlElement [

	(attributes at: 'display') = 'none' ifTrue: [
		aBlElement visibility: BlVisibilityGone new ]
]

{ #category : #'circle & ellipse' }
BlSvgFactory >> ellipseFrom: node [

	| ellipse |
	ellipse := (BlEllipseGeometry new extent:
		            (node attributeAt: 'rx') asNumber * 2
		            @ ((node attributeAt: 'ry') asNumber * 2)) asElement.
	ellipse position: (self ellipsePositionFrom: node).

	self allPropertiesFrom: node attributes on: ellipse.

	^ ellipse
]

{ #category : #'circle & ellipse' }
BlSvgFactory >> ellipsePositionFrom: node [

	| cx cy |
	cx := cy := 0.
	node
		attributeAt: 'cx'
		ifPresent: [ cx := (node attributeAt: 'cx') asNumber ].
	node
		attributeAt: 'cy'
		ifPresent: [ cy := (node attributeAt: 'cy') asNumber ].
	^ (cx - (node attributeAt: 'rx') asNumber) @ (cy - (node attributeAt: 'ry') asNumber)
]

{ #category : #groups }
BlSvgFactory >> extentFrom: node on: aBlElement [

	self flag: #todo. "Implement %"

	node
		attributeAt: 'width'
		ifPresent: [
			| width |
			width := node attributeAt: 'width'.
			width trim last = $% ifTrue: [ self notYetImplemented ].
			aBlElement constraints horizontal exact: width asNumber ]
		ifAbsent: [
			aBlElement constraints horizontal matchParent "100%" ].

	node
		attributeAt: 'height'
		ifPresent: [
			| height |
			height := node attributeAt: 'height'.
			height trim last = $% ifTrue: [ self notYetImplemented ].
			aBlElement constraints vertical exact: height asNumber ]
		ifAbsent: [
			aBlElement constraints vertical matchParent "100%" ]
]

{ #category : #properties }
BlSvgFactory >> fillPropertiesFrom: attributes on: aBlElement [

	| backgroundBuilder |
	attributes at: 'fill' ifPresent: [ 
		backgroundBuilder := BlPaintBackgroundBuilder new.
		backgroundBuilder paint:
			(self paintFrom: (attributes at: 'fill') on: aBlElement).
		attributes
			at: 'fill-opacity'
			ifPresent: [ 
			backgroundBuilder opacity: (attributes at: 'fill-opacity') asNumber ].

		aBlElement background: backgroundBuilder build ]
]

{ #category : #definitions }
BlSvgFactory >> filterFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #groups }
BlSvgFactory >> gFrom: node [

	| groupElement |
	groupElement := BlElement new.
	groupElement clipChildren: false.

	self commonPropertiesFrom: node attributes on: groupElement.

	node nodesDo: [ :child |
		child translatedBy: self withParent: groupElement ].

	^ groupElement
]

{ #category : #translating }
BlSvgFactory >> generateElementFrom: node [

	| symbol |
	node
		splitStyleAttribute;
		inheriteAttributes.

	symbol := (node name asString , 'From:') asSymbol.

	(self respondsTo: symbol)
		ifTrue: [ ^ self perform: symbol with: node ]
		ifFalse: [ ^ self metadataFrom: node ]
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> gradientFrom: node on: aBlGradientPaint [

	| stopCollection |
	stopCollection := OrderedCollection new.
	node nodesDo: [ :child |
		| keyAndValue |
		keyAndValue := child translatedBy: self withParent: aBlGradientPaint.
		keyAndValue ifNotNil: [ stopCollection add: keyAndValue ] ].
	aBlGradientPaint stops: stopCollection.

	self idHandlingFrom: node attributes on: aBlGradientPaint
]

{ #category : #properties }
BlSvgFactory >> idHandlingFrom: attributes on: anObject [

	self definitions at: (attributes at: 'id') put: anObject
]

{ #category : #image }
BlSvgFactory >> imageFrom: node [

	| imageElement |
	imageElement := self rectFrom: node.

	node attributeAt: 'xlink:href' ifPresent: [
		imageElement background: (BlImagePatternPaint form:
				 (Form fromFileNamed: (node attributeAt: 'xlink:href'))) ].

	^ imageElement
]

{ #category : #line }
BlSvgFactory >> lineEndingPointFrom: node [

	| x2 y2 |
	x2 := y2 := 0.
	node
		attributeAt: 'x2'
		ifPresent: [ x2 := (node attributeAt: 'x2') asNumber ].
	node
		attributeAt: 'y2'
		ifPresent: [ y2 := (node attributeAt: 'y2') asNumber ].
	^ x2 @ y2
]

{ #category : #line }
BlSvgFactory >> lineFrom: node [

	| line |
	line := BlElement new.
	line geometry:
		(BlLineGeometry
			from: (self lineStartingPointFrom: node)
			to: (self lineEndingPointFrom: node)).
	
	self allPropertiesFrom: node attributes on: line.
	
	^ line
]

{ #category : #line }
BlSvgFactory >> lineStartingPointFrom: node [

	| x1 y1 |
	x1 := y1 := 0.
	node
		attributeAt: 'x1'
		ifPresent: [ x1 := (node attributeAt: 'x1') asNumber ].
	node
		attributeAt: 'y1'
		ifPresent: [ y1 := (node attributeAt: 'y1') asNumber ].
	^ x1 @ y1
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> linearGradientEndingPointFrom: node [

	| x2 y2 |
	x2 := 100.
	y2 := 0.
	node
		attributeAt: 'x2'
		ifPresent: [ x2 := (node attributeAt: 'x2') asNumber ].
	node
		attributeAt: 'y2'
		ifPresent: [ y2 := (node attributeAt: 'y2') asNumber ].
	^ x2 @ y2
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> linearGradientFrom: node [

	| aBlGradientPaint |
	aBlGradientPaint := BlLinearGradientPaint new
		start: (self linearGradientStartingPointFrom: node);
		end: (self linearGradientEndingPointFrom: node);
		yourself.
	
	self gradientFrom: node on: aBlGradientPaint
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> linearGradientStartingPointFrom: node [

	| x1 y1 |
	x1 := y1 := 0.
	node
		attributeAt: 'x1'
		ifPresent: [ x1 := (node attributeAt: 'x1') asNumber ].
	node
		attributeAt: 'y1'
		ifPresent: [ y1 := (node attributeAt: 'y1') asNumber ].
	^ x1 @ y1
]

{ #category : #definitions }
BlSvgFactory >> markerFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #definitions }
BlSvgFactory >> maskFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #transformations }
BlSvgFactory >> matrixElement: aBlElement with: anOrderedCollection [

	aBlElement transformDo: [ :t |
		t matrix:
			(BlMatrix2D new
				x: (anOrderedCollection at: 5);
				y: (anOrderedCollection at: 6);
				sx: (anOrderedCollection at: 1);
				sy: (anOrderedCollection at: 4);
				shx: (anOrderedCollection at: 3);
				shy: (anOrderedCollection at: 2)) ]
]

{ #category : #metadata }
BlSvgFactory >> metadataFrom: attributes [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #properties }
BlSvgFactory >> paintFrom: aString on: aBlElement [

	^ (self definitions
		at: ((aString withoutPrefix: 'url(#') withoutSuffix: ')')
		ifPresent: [ :aBlPaint | aBlPaint veryDeepCopy ]
		ifAbsent: [ BlColorPaint color: (BlSvgColor fromString: aString) ])
			adaptedToElement: aBlElement
]

{ #category : #path }
BlSvgFactory >> pathFrom: node [

	| pathString pathElement |
	pathString := node attributeAt: 'd'.
	pathElement := BlElement new
		geometry: (BlSvgPath pathString: pathString);
		beOutskirtsCentered;
		background: Color black;
		border: (BlBorder paint: Color gray width: 2);
		yourself.

	self allPropertiesFrom: node attributes on: pathElement.

	^ pathElement
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> patternFrom: node [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #'polyline & polygon' }
BlSvgFactory >> pointsFrom: node [

	node attributeAt: 'points' ifPresent: [
		^ ((node attributeAt: 'points') substrings: ' ') collect: [ :XAndY |
			  (XAndY copyUpTo: $,) asNumber @ (XAndY copyAfter: $,) asNumber ] ]
]

{ #category : #'polyline & polygon' }
BlSvgFactory >> polygonFrom: node [

	| polygon |
	polygon := (BlPolygonGeometry vertices: (self pointsFrom: node)) asElement.

	self allPropertiesFrom: node attributes on: polygon.

	^ polygon
]

{ #category : #'polyline & polygon' }
BlSvgFactory >> polylineFrom: node [

	| polyline points |
	points := self pointsFrom: node.
	polyline := BlElement new.
	polyline geometry: (BlPolylineGeometry vertices: points).

	self commonPropertiesFrom: node attributes on: polyline.

	^ polyline
]

{ #category : #groups }
BlSvgFactory >> positionFrom: node on: aBlElement [

	| x y |
	x := y := 0.
	node
		attributeAt: 'x'
		ifPresent: [ x := (node attributeAt: 'x') asNumber ].
	node
		attributeAt: 'y'
		ifPresent: [ y := (node attributeAt: 'y') asNumber ].
	aBlElement position: x @ y
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> radialGradientCenterFrom: node [

	| cx cy |
	cx := cy := 50.
	node
		attributeAt: 'cx'
		ifPresent: [ cx := (node attributeAt: 'cx') asNumber ].
	node
		attributeAt: 'cy'
		ifPresent: [ cy := (node attributeAt: 'cy') asNumber ].
	^ cx @ cy
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> radialGradientFocalPointFrom: node on: aBlRadialGradientPaint [

	| fx fy |
	fx := aBlRadialGradientPaint center x.
	fy := aBlRadialGradientPaint center y.
	node
		attributeAt: 'fx'
		ifPresent: [ fx := (node attributeAt: 'fx') asNumber ].
	node
		attributeAt: 'fy'
		ifPresent: [ fy := (node attributeAt: 'fy') asNumber ].
	aBlRadialGradientPaint center: fx @ fy
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> radialGradientFrom: node [

	| aBlSVGGradientPaint |
	aBlSVGGradientPaint := BlRadialGradientPaint new
		                       center: (self radialGradientCenterFrom: node);
		                       radius: (self radialGradientRadiusFrom: node);
		                       yourself.
	self radialGradientFocalPointFrom: node on: aBlSVGGradientPaint.

	self gradientFrom: node on: aBlSVGGradientPaint
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> radialGradientRadiusFrom: node [

	| r |
	r := 50.
	node
		attributeAt: 'r'
		ifPresent: [ r := (node attributeAt: 'r') asNumber ].
	^ r
]

{ #category : #rectangle }
BlSvgFactory >> rectCornerRadiusFrom: node [

	| rx ry maxRadius maxAllowed |
	rx := ry := 0.
	node
		attributeAt: 'rx'
		ifPresent: [ rx := (node attributeAt: 'rx') asNumber ].
	node
		attributeAt: 'ry'
		ifPresent: [ rx := (node attributeAt: 'ry') asNumber ].

	maxRadius := rx max: ry.
	maxAllowed := ((node attributeAt: 'width') asNumber min:
		               (node attributeAt: 'height') asNumber) / 2.
	^ maxRadius min: maxAllowed
]

{ #category : #rectangle }
BlSvgFactory >> rectFrom: node [

	| rectangle |
	rectangle := ((BlRoundedRectangleGeometry cornerRadius:
			               (self rectCornerRadiusFrom: node))
		              extent: (node attributeAt: 'width') asNumber
			              @ (node attributeAt: 'height') asNumber;
		              yourself) asElement.
	self positionFrom: node on: rectangle.

	self allPropertiesFrom: node attributes on: rectangle.

	^ rectangle
]

{ #category : #properties }
BlSvgFactory >> renderingPropertiesFrom: attributes on: aBlElement [

	self transformPropertiesFrom: attributes on: aBlElement.

	attributes
		at: 'opacity'
		ifPresent: [
			aBlElement opacity: (attributes at: 'opacity') asNumber ].
	self fillPropertiesFrom: attributes on: aBlElement.
	self strokePropertiesFrom: attributes on: aBlElement
]

{ #category : #definitions }
BlSvgFactory >> reset [

	definitions := WeakKeyDictionary new.
	classes := WeakKeyDictionary new
]

{ #category : #text }
BlSvgFactory >> ropedTextFrom: node on: textElement [

	| text textAttributes |
	text := BlRopedText string: node nodes first string trimBoth.

	textAttributes := OrderedCollection new.
	node attributes at: 'font-family' ifPresent: [
		textAttributes add:
			(BlFontFamilyAttribute named: (node attributeAt: 'font-family')) ].
	node attributes at: 'font-size' ifPresent: [
		textAttributes add:
			(BlFontSizeAttribute size: (node attributeAt: 'font-size') asNumber) ].
	node attributes at: 'font-color' ifPresent: [
		textAttributes add: (BlTextForegroundAttribute paint:
				 (self paintFrom: (node attributeAt: 'font-color') on: textElement)
					 color) ].
	text attributes: textAttributes.

	textElement text: text
]

{ #category : #transformations }
BlSvgFactory >> rotateElement: aBlElement with: anOrderedCollection [

	self flag: #todo.
	self notYetImplemented
"	| r cx cy |
	cx := cy := 0.
	r := anOrderedCollection first.
	anOrderedCollection size = 3 ifTrue: [
		cx := anOrderedCollection second.
		cy := anOrderedCollection last ].

	aBlElement
		rotateByDegrees: r
		center: cx - aBlElement position x @ (cy - aBlElement position y)"
]

{ #category : #transformations }
BlSvgFactory >> scaleElement: aBlElement with: anOrderedCollection [

	| sx sy |
	sy := sx := anOrderedCollection first.
	anOrderedCollection size = 2 ifTrue: [
		sy := anOrderedCollection last ].

	aBlElement scaleBy: sx @ sy
]

{ #category : #text }
BlSvgFactory >> setAttributesForTextFrom: node [
	"In svg the fill attribute from the text element commands the text color, not the background color.
	That's why Bloc should treat this attribute the same way it does the stroke attribute from the other svg elements."

	node attributes at: 'fill' ifPresent: [
		node attributeAt: 'font-color' put: (node attributeAt: 'fill').
		node removeAttribute: 'fill' ].
	node attributes at: 'fill-opacity' ifPresent: [
		node attributeAt: 'opacity' put: (node attributeAt: 'fill-opacity').
		node removeAttribute: 'fill-opacity' ]
]

{ #category : #transformations }
BlSvgFactory >> skewXElement: aBlElement with: anOrderedCollection [

	self flag: #todo.
	self notYetImplemented
"	aBlElement skewBy: anOrderedCollection first degreesToRadians @ 0"
]

{ #category : #transformations }
BlSvgFactory >> skewYElement: aBlElement with: anOrderedCollection [

	self flag: #todo.
	self notYetImplemented.
	"aBlElement skewBy: 0 @ (anOrderedCollection first degreesToRadians)"
]

{ #category : #'gradients & patterns' }
BlSvgFactory >> stopFrom: node [

	| offsetString offset color |
	offsetString := node attributeAt: 'offset'.
	(offsetString beginsWith: '.') ifTrue: [
		offsetString := '0', offsetString ].
	offset :=
		(offsetString endsWith: '%')
			ifTrue: [ (offsetString withoutSuffix: '%') asNumber / 100 ]
			ifFalse: [ offsetString asNumber ].

	color := BlSvgColor fromString: (node attributeAt: 'stop-color').

	^ offset asFloat -> color
]

{ #category : #properties }
BlSvgFactory >> strokePropertiesFrom: attributes on: aBlElement [

	| borderBuilder dashArray |
	attributes at: 'stroke' ifPresent: [
		borderBuilder := BlBorderBuilder new.
		borderBuilder paint:
			(self paintFrom: (attributes at: 'stroke') on: aBlElement).
		attributes
			at: 'stroke-width'
			ifPresent: [
			borderBuilder width: (attributes at: 'stroke-width') asNumber ].
		attributes
			at: 'stroke-opacity'
			ifPresent: [
			borderBuilder opacity: (attributes at: 'stroke-opacity') asNumber ].

		attributes at: 'stroke-linecap' ifPresent: [
			borderBuilder lineCap:
				(BlStrokeLineCap perform:
					 (attributes at: 'stroke-linecap') asSymbol) ].
		attributes at: 'stroke-linejoin' ifPresent: [
			borderBuilder lineJoin:
				(BlStrokeLineJoin perform:
					 (attributes at: 'stroke-linejoin') asSymbol) ].
		attributes at: 'stroke-miterlimit' ifPresent: [
			borderBuilder miterLimit:
				(attributes at: 'stroke-miterlimit') asNumber ].

		attributes at: 'stroke-dasharray' ifPresent: [
			dashArray := ((attributes at: 'stroke-dasharray') substrings: {
					              Character space.
					              $, }) collect: [ :value | value asNumber ].
			borderBuilder dashArray: dashArray ].
		attributes at: 'stroke-dashoffset' ifPresent: [
			borderBuilder dashOffset:
				(attributes at: 'stroke-dashoffset') asNumber ].

		aBlElement border: borderBuilder build ]
]

{ #category : #groups }
BlSvgFactory >> svgFrom: node [

	| rootElement |
	rootElement := self gFrom: node.

	self positionFrom: node on: rootElement.
	self extentFrom: node on: rootElement.
	self viewBoxFrom: node on: rootElement.

	^ rootElement
]

{ #category : #definitions }
BlSvgFactory >> symbolFrom: node [
	"Behaves like a 'svg' but won't be added to any parent because is always a reference, see 'XMLElement >> translatedBy:withParent:' "

	^ self svgFrom: node
]

{ #category : #text }
BlSvgFactory >> textFrom: node [

	| textElement |
	textElement := self gFrom: node.
	textElement addChild: (self tspanFrom: node).

	^ textElement
]

{ #category : #metadata }
BlSvgFactory >> titleFrom: attributes [

	self flag: #todo.
	self notYetImplemented
]

{ #category : #properties }
BlSvgFactory >> transformPropertiesFrom: attributes on: aBlElement [

	| transformations |
	attributes
		at: 'transform'
		ifPresent: [
		transformations := (attributes at: 'transform') substrings: ' ' ].
	transformations ifNil: [ ^ self ].

	transformations do: [ :transformation |
		| sel args symbol |
		sel := nil.
		args := OrderedCollection new.
		(transformation substrings: { $(. $,. $) }) do: [ :string |
			sel
				ifNil: [ sel := string ]
				ifNotNil: [ args add: string asNumber ] ].

		symbol := (sel , 'Element:with:') asSymbol.
		(self respondsTo: symbol) ifTrue: [
			self perform: symbol with: aBlElement with: args ] ]
]

{ #category : #transformations }
BlSvgFactory >> translateElement: aBlElement with: anOrderedCollection [

	| x y |
	y := 0.
	x := anOrderedCollection first.
	anOrderedCollection size = 2 ifTrue: [ y := anOrderedCollection last ].

	aBlElement transformDo: [ :t | t inherit translateBy: x @ y ]
]

{ #category : #text }
BlSvgFactory >> tspanFrom: node [

	| textElement |
	self setAttributesForTextFrom: node.

	textElement := BlTextElement new
		               constraintsDo: [ :c |
			               c horizontal fitContent.
			               c vertical fitContent ];
		               yourself.
	self ropedTextFrom: node on: textElement.
	self positionFrom: node on: textElement.

	self allPropertiesFrom: node attributes on: textElement.

	^ textElement
]

{ #category : #definitions }
BlSvgFactory >> useFrom: node [

	| element |
	element := (self definitions
		at: ((node attributeAt: 'xlink:href') withoutPrefix: '#')) veryDeepCopy.
	element parent: nil.

	self positionFrom: node on: element.
	self extentFrom: node on: element.
	self allPropertiesFrom: node attributes on: element.

	^ element
]

{ #category : #groups }
BlSvgFactory >> viewBoxFrom: node on: aBlElement [

	| array updateTransformationBlock |
	node attributeAt: 'viewBox' ifPresent: [
		array := ((node attributeAt: 'viewBox') substrings: ' ,')
			collect: [ :valueString | valueString asNumber ].

		updateTransformationBlock := [
			| offset scale |
			offset := array first negated @ array second negated.
			scale := (aBlElement width / array third)
					@ (aBlElement height / array fourth).

			#updateTransformationBlock traceCr.
			scale traceCr.

			aBlElement transformDo: [ :t |
				t translateBy: offset.
				t topLeftOrigin; scaleBy: scale ] ].
		
		aBlElement
			whenLayoutedDoOnce: updateTransformationBlock.
		aBlElement
			addEventHandlerOn: BlElementExtentChangedEvent
			do: [ :evt |
				updateTransformationBlock value ].
		"aBlElement forceLayout" ]
]
