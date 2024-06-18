"
I am a factory that converts SVG to Bloc via XML-Parser. 

My instance variable 'definitions' is a Dictionary used to store previously created objects when they have a 'id' attribute, so that they may be re-used in the same SVG file.

Example of uses that return a converted BlElement:
    - `BlSVGConverter` convertFromString: aString
    - `BlSVGConverter` convertFromFile: aFileName
    - `BlSVGConverter` convertFromURL: anUrl
"
Class {
	#name : #BlSvgConverter,
	#superclass : #Object,
	#instVars : [
		'definitions'
	],
	#category : #'Bloc-SVG-Converter'
}

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromFile: aFileName [

	| doc |
	doc := XMLDOMParser parseFileNamed: aFileName.
	^ self convertXMLDocument: doc
]

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromString: aString [

	| doc |
	doc := XMLDOMParser parse: aString.
	^ self convertXMLDocument: doc
]

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromURL: anUrl [

	| doc |
	doc := XMLDOMParser parse: anUrl asZnUrl retrieveContents asString.
	^ self convertXMLDocument: doc
]

{ #category : #'instance creation' }
BlSvgConverter class >> convertXMLDocument: doc [

	| nodeElements aConverter |
	aConverter := self new.
	nodeElements := doc nodes elements.
	(nodeElements size = 1 and: [ nodeElements first name = 'svg' ])
		ifFalse: [ self error: 'A root svg element was expected' ].

	^ aConverter svgFrom: nodeElements first
]

{ #category : #properties }
BlSvgConverter >> allPropertiesFrom: attributes on: aBlElement [

	self renderingPropertiesFrom: attributes on: aBlElement.
	self commonPropertiesFrom: attributes on: aBlElement
]

{ #category : #'circle & ellipse' }
BlSvgConverter >> circleFrom: node [

	| radius |
	radius := node attributeAt: 'r'.
	node
		attributeAt: 'rx' put: radius;
		attributeAt: 'ry' put: radius.

	^ self ellipseFrom: node
]

{ #category : #properties }
BlSvgConverter >> commonPropertiesFrom: attributes on: aBlElement [

	self displayPropertyFrom: attributes on: aBlElement.
	self idHandlingFrom: attributes on: aBlElement
]

{ #category : #definitions }
BlSvgConverter >> definitions [

	^ definitions
]

{ #category : #definitions }
BlSvgConverter >> defsFrom: node [
	"Behaves like a 'g' but won't be added to any parent because always contains references, see 'XMLElement >> translatedBy:withParent:' "

	^ self gFrom: node
]

{ #category : #properties }
BlSvgConverter >> displayPropertyFrom: attributes on: aBlElement [

	attributes
		at: 'display'
		ifPresent: [ :display |
			display = 'none' ifTrue: [
				aBlElement visibility: BlVisibility gone ]]
]

{ #category : #'circle & ellipse' }
BlSvgConverter >> ellipseFrom: node [

	| ellipse |
	ellipse := self newShapeElement.
	ellipse geometry: BlEllipseGeometry new.
	ellipse size:
		((node attributeAt: 'rx') asNumber * 2) @
		((node attributeAt: 'ry') asNumber * 2).
	ellipse position: (self ellipsePositionFrom: node).

	self allPropertiesFrom: node attributes on: ellipse.

	^ ellipse
]

{ #category : #'circle & ellipse' }
BlSvgConverter >> ellipsePositionFrom: node [

	| cx cy |
	cx := cy := 0.
	node
		attributeAt: 'cx'
		ifPresent: [ :value | cx := value asNumber ].
	node
		attributeAt: 'cy'
		ifPresent: [ :value | cy := value asNumber ].

	^ Point
		x: (cx - (node attributeAt: 'rx') asNumber)
		y: (cy - (node attributeAt: 'ry') asNumber)
]

{ #category : #groups }
BlSvgConverter >> extentFrom: node on: aBlElement [

	node
		attributeAt: 'width'
		ifPresent: [ :width |
			width trim last = $% ifTrue: [ self notYetImplemented ].
			aBlElement constraints horizontal exact: width asNumber ]
		ifAbsent: [
			aBlElement constraints horizontal matchParent "100%" ].

	node
		attributeAt: 'height'
		ifPresent: [ :height |
			height trim last = $% ifTrue: [ self notYetImplemented ].
			aBlElement constraints vertical exact: height asNumber ]
		ifAbsent: [
			aBlElement constraints vertical matchParent "100%" ]
]

{ #category : #properties }
BlSvgConverter >> fillPropertiesFrom: attributes on: aBlElement [

	| backgroundBuilder |
	attributes at: 'fill' ifPresent: [ :fill |
		backgroundBuilder := BlPaintBackgroundBuilder new.
		backgroundBuilder paint:
			(self paintFrom: fill on: aBlElement).
		attributes
			at: 'fill-opacity'
			ifPresent: [ :fillOpacity |
				backgroundBuilder opacity: fillOpacity asNumber ].

		aBlElement background: backgroundBuilder build ]
]

{ #category : #groups }
BlSvgConverter >> gFrom: node [

	| groupElement |
	groupElement := self newTransparentElement.

	self commonPropertiesFrom: node attributes on: groupElement.

	node nodesDo: [ :child |
		child readElementBy: self withParent: groupElement ].

	^ groupElement
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> gradientFrom: node on: aBlGradientPaint [

	| stopCollection |
	stopCollection := OrderedCollection new.
	node nodesDo: [ :child |
		| keyAndValue |
		keyAndValue := child readElementBy: self withParent: aBlGradientPaint.
		keyAndValue ifNotNil: [ stopCollection add: keyAndValue ] ].
	aBlGradientPaint stops: stopCollection.

	self idHandlingFrom: node attributes on: aBlGradientPaint
]

{ #category : #definitions }
BlSvgConverter >> hrefFrom: node ifAbsent: absentBlock [
	"Answer the href string from the node. This might be the value either in the 'xlink:href' or the 'href' attribute. The former was deprecated in the SVG 2 spec (https://svgwg.org/svg2-draft/struct.html#UseElement)."

	^ node
		attributeAt: 'href'
		ifAbsent: [
			node
				attributeAt: 'xlink:href'
				ifAbsent: absentBlock ]
]

{ #category : #properties }
BlSvgConverter >> idHandlingFrom: attributes on: aBlElement [

	attributes
		at: 'id'
		ifPresent: [ :id | definitions at: id put: aBlElement ]
]

{ #category : #image }
BlSvgConverter >> imageFrom: node [

	| imageElement href |
	imageElement := self rectFrom: node.

	href := self hrefFrom: node ifAbsent: [ ^ imageElement ].

	imageElement background:
		(BlImagePatternPaint form: (Form fromFileNamed: href)).

	^ imageElement
]

{ #category : #initialization }
BlSvgConverter >> initialize [

	super initialize.
	
	self reset
]

{ #category : #line }
BlSvgConverter >> lineEndingPointFrom: node [

	| x2 y2 |
	x2 := y2 := 0.
	node
		attributeAt: 'x2'
		ifPresent: [ :value | x2 := value asNumber ].
	node
		attributeAt: 'y2'
		ifPresent: [ :value | y2 := value asNumber ].
	^ x2 @ y2
]

{ #category : #line }
BlSvgConverter >> lineFrom: node [

	| line |
	line := self newShapeElement.
	line geometry:
		(BlLineGeometry
			from: (self lineStartingPointFrom: node)
			to: (self lineEndingPointFrom: node)).
	
	self allPropertiesFrom: node attributes on: line.
	
	^ line
]

{ #category : #line }
BlSvgConverter >> lineStartingPointFrom: node [

	| x1 y1 |
	x1 := y1 := 0.
	node
		attributeAt: 'x1'
		ifPresent: [ :value | x1 := value asNumber ].
	node
		attributeAt: 'y1'
		ifPresent: [ :value | y1 := value asNumber ].
	^ x1 @ y1
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> linearGradientEndingPointFrom: node [

	| x2 y2 |
	x2 := 100.
	y2 := 0.
	node
		attributeAt: 'x2'
		ifPresent: [ :value | x2 := value asNumber ].
	node
		attributeAt: 'y2'
		ifPresent: [ :value | y2 := value asNumber ].
	^ x2 @ y2
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> linearGradientFrom: node [

	| aBlGradientPaint |
	aBlGradientPaint := BlLinearGradientPaint new
		start: (self linearGradientStartingPointFrom: node);
		end: (self linearGradientEndingPointFrom: node);
		yourself.
	
	self gradientFrom: node on: aBlGradientPaint
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> linearGradientStartingPointFrom: node [

	| x1 y1 |
	x1 := y1 := 0.
	node
		attributeAt: 'x1'
		ifPresent: [ :value | x1 := value asNumber ].
	node
		attributeAt: 'y1'
		ifPresent: [ :value | y1 := value asNumber ].
	^ x1 @ y1
]

{ #category : #transformations }
BlSvgConverter >> matrixElement: aBlElement with: anOrderedCollection [

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

{ #category : #'instance creation' }
BlSvgConverter >> newShapeElement [
	"Answer an element with the default properties for a SVG shape"

	^ self newTransparentElement
		background: Color black;
		yourself
]

{ #category : #'instance creation' }
BlSvgConverter >> newTransparentElement [

	^ BlElement new
		beOutskirtsCentered;
		clipChildren: false;
		yourself
]

{ #category : #properties }
BlSvgConverter >> paintFrom: aString on: aBlElement [

	^ (definitions
		at: ((aString withoutPrefix: 'url(#') withoutSuffix: ')')
		ifPresent: [ :aBlPaint | aBlPaint veryDeepCopy ]
		ifAbsent: [ BlColorPaint color: (BlSvgColor fromString: aString) ])
			adaptedToElement: aBlElement
]

{ #category : #path }
BlSvgConverter >> pathFrom: node [

	| aGeometry pathElement |
	aGeometry := BlSvgPath pathString: (node attributeAt: 'd').

	pathElement := self newShapeElement.
	pathElement geometry: aGeometry.

	self allPropertiesFrom: node attributes on: pathElement.

	"Only apply if value is not the default"
	node attributes
		at: 'fill-rule'
		ifPresent: [ :value |
			value = 'evenodd' ifTrue: [ aGeometry useEvenOddFillRule ] ].

	^ pathElement
]

{ #category : #'polyline & polygon' }
BlSvgConverter >> pointsFrom: node [

	node attributeAt: 'points' ifPresent: [ :value |
		^ (value substrings: ' ') collect: [ :xAndY |
			(xAndY copyUpTo: $,) asNumber @
			(xAndY copyAfter: $,) asNumber ] ]
]

{ #category : #'polyline & polygon' }
BlSvgConverter >> polygonFrom: node [

	| polygon |
	polygon := self newShapeElement.
	polygon geometry: (BlPolygonGeometry vertices: (self pointsFrom: node)).

	self allPropertiesFrom: node attributes on: polygon.

	^ polygon
]

{ #category : #'polyline & polygon' }
BlSvgConverter >> polylineFrom: node [

	| polyline points |
	points := self pointsFrom: node.

	polyline := self newShapeElement
		geometry: (BlPolylineGeometry vertices: points);
		yourself.

	self allPropertiesFrom: node attributes on: polyline.

	^ polyline
]

{ #category : #groups }
BlSvgConverter >> positionFrom: node on: aBlElement [

	| x y |
	x := y := 0.
	node
		attributeAt: 'x'
		ifPresent: [ :value | x := value asNumber ].
	node
		attributeAt: 'y'
		ifPresent: [ :value | y := value asNumber ].
	aBlElement position: x @ y
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> radialGradientFrom: node [

	| aBlRadialGradientPaint r cx cy fx fy |
	aBlRadialGradientPaint := BlRadialGradientPaint new.

	r := 0.5.
	node
		attributeAt: 'r'
		ifPresent: [ :value | r := value asNumber ].
	aBlRadialGradientPaint radius: r.

	cx := cy := 0.0.
	node
		attributeAt: 'cx'
		ifPresent: [ :value | cx := value asNumber ].
	node
		attributeAt: 'cy'
		ifPresent: [ :value | cy := value asNumber ].
	aBlRadialGradientPaint outerCenter: cx @ cy.

	fx := cx.
	fy := cy.
	node
		attributeAt: 'fx'
		ifPresent: [ :value | fx := value asNumber ].
	node
		attributeAt: 'fy'
		ifPresent: [ :value | fy := value asNumber ].
	aBlRadialGradientPaint innerCenter: fx @ fy.

	self gradientFrom: node on: aBlRadialGradientPaint
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> radialGradientRadiusFrom: node [

	| r |
	r := 50.
	node
		attributeAt: 'r'
		ifPresent: [ :value | r := value asNumber ].
	^ r
]

{ #category : #translating }
BlSvgConverter >> readElementFrom: aXMLNode [

	| symbol |
	aXMLNode
		splitStyleAttribute;
		inheritAttributes.

	symbol := (aXMLNode name asString , 'From:') asSymbol.

	^ self perform: symbol with: aXMLNode
]

{ #category : #rectangle }
BlSvgConverter >> rectCornerRadiusFrom: node [

	| rx ry maxRadius maxAllowed |
	rx := ry := 0.
	node
		attributeAt: 'rx'
		ifPresent: [ :value | rx := value asNumber ].
	node
		attributeAt: 'ry'
		ifPresent: [ :value | rx := value asNumber ].

	maxRadius := rx max: ry.
	maxAllowed :=
		((node attributeAt: 'width') asNumber min:
		(node attributeAt: 'height') asNumber) / 2.

	^ maxRadius min: maxAllowed
]

{ #category : #rectangle }
BlSvgConverter >> rectFrom: node [

	| rectangle |
	rectangle := self newShapeElement.
	rectangle geometry:
		(BlRoundedRectangleGeometry cornerRadius:
			(self rectCornerRadiusFrom: node)).
	rectangle size:
		(node attributeAt: 'width') asNumber @
		(node attributeAt: 'height') asNumber.
	self positionFrom: node on: rectangle.

	self allPropertiesFrom: node attributes on: rectangle.

	^ rectangle
]

{ #category : #properties }
BlSvgConverter >> renderingPropertiesFrom: attributes on: aBlElement [

	self transformPropertiesFrom: attributes on: aBlElement.

	attributes
		at: 'opacity'
		ifPresent: [ :opacity |
			aBlElement opacity: opacity asNumber ].

	self fillPropertiesFrom: attributes on: aBlElement.
	self strokePropertiesFrom: attributes on: aBlElement
]

{ #category : #definitions }
BlSvgConverter >> reset [

	definitions := WeakKeyDictionary new
]

{ #category : #text }
BlSvgConverter >> ropedTextFrom: node on: textElement [

	| text textAttributes |
	text := BlRopedText string: node nodes first string trimBoth.

	textAttributes := OrderedCollection new.
	node attributes
		at: 'font-family'
		ifPresent: [ :value |
			textAttributes add:
				(BlFontFamilyAttribute named: value) ].
	node attributes
		at: 'font-size'
		ifPresent: [ :value |
			textAttributes add:
				(BlFontSizeAttribute size: value asNumber) ].
	node attributes
		at: 'font-color'
		ifPresent: [ :value |
			textAttributes add:
				(BlTextForegroundAttribute paint:
					(self paintFrom: value on: textElement) color) ].
	text attributes: textAttributes.

	textElement text: text
]

{ #category : #transformations }
BlSvgConverter >> rotateElement: aBlElement with: anOrderedCollection [

	| r cx cy |
	cx := cy := 0.
	r := anOrderedCollection first.
	anOrderedCollection size = 3 ifTrue: [
		cx := anOrderedCollection second.
		cy := anOrderedCollection last ].

	aBlElement transformDo: [ :t |
		| rotationCenter |
		rotationCenter := (cx - aBlElement position x) @ (cy - aBlElement position y).
		t inherit
			origin: (BlAffineTransformationPositionOrigin position: rotationCenter);
			rotateBy: r ]
]

{ #category : #transformations }
BlSvgConverter >> scaleElement: aBlElement with: anOrderedCollection [

	| sx sy |
	sy := sx := anOrderedCollection first.
	anOrderedCollection size = 2 ifTrue: [
		sy := anOrderedCollection last ].

	aBlElement transformDo: [ :t | t inherit scaleBy: sx @ sy ]
]

{ #category : #text }
BlSvgConverter >> setAttributesForTextFrom: node [
	"In svg the fill attribute from the text element commands the text color, not the background color.
	That's why Bloc should treat this attribute the same way it does the stroke attribute from the other svg elements."

	node attributes at: 'fill' ifPresent: [ :fill |
		node attributeAt: 'font-color' put: fill.
		node removeAttribute: 'fill' ].
	node attributes at: 'fill-opacity' ifPresent: [ :fillOpacity |
		node attributeAt: 'opacity' put: fillOpacity.
		node removeAttribute: 'fill-opacity' ]
]

{ #category : #transformations }
BlSvgConverter >> skewXElement: aBlElement with: anOrderedCollection [

	| angle |
	angle := anOrderedCollection first.

	aBlElement transformDo: [ :t | t inherit skewX: angle ]
]

{ #category : #transformations }
BlSvgConverter >> skewYElement: aBlElement with: anOrderedCollection [

	| angle |
	angle := anOrderedCollection first.

	aBlElement transformDo: [ :t | t inherit skewY: angle ]
]

{ #category : #'gradients & patterns' }
BlSvgConverter >> stopFrom: node [

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
BlSvgConverter >> strokePropertiesFrom: attributes on: aBlElement [

	attributes at: 'stroke' ifPresent: [ :stroke |
		| borderBuilder |
		borderBuilder := BlBorderBuilder new.
		borderBuilder paint: (self paintFrom: stroke on: aBlElement).
		attributes
			at: 'stroke-width'
			ifPresent: [ :strokeWidth |
				borderBuilder width: strokeWidth asNumber ].
		attributes
			at: 'stroke-opacity'
			ifPresent: [ :strokeOpacity |
				borderBuilder opacity: strokeOpacity asNumber ].

		attributes
			at: 'stroke-linecap'
			ifPresent: [ :lineCap |
				borderBuilder lineCap:
					(BlStrokeLineCap perform: lineCap asSymbol) ].
		attributes
			at: 'stroke-linejoin'
			ifPresent: [ :lineJoin |
				borderBuilder lineJoin:
					(BlStrokeLineJoin perform: lineJoin asSymbol) ].
		attributes
			at: 'stroke-miterlimit'
			ifPresent: [ :miterLimit |
				borderBuilder miterLimit: miterLimit asNumber ].

		attributes
			at: 'stroke-dasharray'
			ifPresent: [ :dashes |
				| dashArray |
				dashArray :=
					(dashes substrings: {
						Character space.
						$, }) collect: [ :each | each asNumber ].
				borderBuilder dashArray: dashArray ].

		attributes
			at: 'stroke-dashoffset'
			ifPresent: [ :offset |
				borderBuilder dashOffset: offset asNumber ].

		aBlElement border: borderBuilder build ]
]

{ #category : #groups }
BlSvgConverter >> svgFrom: node [

	| rootElement |
	rootElement := self gFrom: node.

	self positionFrom: node on: rootElement.
	self extentFrom: node on: rootElement.
	self viewBoxFrom: node on: rootElement.

	^ rootElement
]

{ #category : #definitions }
BlSvgConverter >> symbolFrom: node [
	"Behaves like a 'svg' but won't be added to any parent because is always a reference, see 'XMLElement >> translatedBy:withParent:' "

	^ self svgFrom: node
]

{ #category : #text }
BlSvgConverter >> textFrom: node [

	| textElement |
	textElement := self gFrom: node.
	textElement addChild: (self tspanFrom: node).

	^ textElement
]

{ #category : #properties }
BlSvgConverter >> transformPropertiesFrom: attributes on: aBlElement [

	| transformations |
	transformations := attributes
		at: 'transform'
		ifAbsent: [ ^ self ].
	(transformations substrings: ' ') do: [ :transformation |
		| sel args symbol |
		sel := nil.
		args := OrderedCollection new.
		(transformation substrings: { $(. $,. $) }) do: [ :string |
			sel
				ifNil: [ sel := string ]
				ifNotNil: [ args add: string asNumber ] ].

		symbol := (sel, 'Element:with:') asSymbol.
		(self respondsTo: symbol) ifTrue: [
			self perform: symbol with: aBlElement with: args ] ]
]

{ #category : #transformations }
BlSvgConverter >> translateElement: aBlElement with: anOrderedCollection [

	| x y |
	y := 0.
	x := anOrderedCollection first.
	anOrderedCollection size = 2 ifTrue: [ y := anOrderedCollection last ].

	aBlElement transformDo: [ :t | t inherit translateBy: x @ y ]
]

{ #category : #text }
BlSvgConverter >> tspanFrom: node [

	| textElement |
	self setAttributesForTextFrom: node.

	textElement := BlTextElement new
							constraintsDo: [ :c |
								c horizontal fitContent.
								c vertical fitContent ];
							beOutskirtsCentered;
							clipChildren: false;
							yourself.
	self ropedTextFrom: node on: textElement.
	self positionFrom: node on: textElement.

	self allPropertiesFrom: node attributes on: textElement.

	^ textElement
]

{ #category : #definitions }
BlSvgConverter >> useFrom: node [

	| href element |
	href := self hrefFrom: node ifAbsent: [ self error ].

	"We assume the href value starts with # and
	it is the id of a previously defined shape."
	element := definitions at: (href withoutPrefix: '#').
	element := element veryDeepCopy.
	element parent: nil.

	self positionFrom: node on: element.
	self extentFrom: node on: element.
	self allPropertiesFrom: node attributes on: element.

	^ element
]

{ #category : #groups }
BlSvgConverter >> viewBoxFrom: node on: aBlElement [

	| array updateTransformationBlock |
	node attributeAt: 'viewBox' ifPresent: [ :value |
		array := (value substrings: ' ,')
			collect: [ :valueString | valueString asNumber ].

		updateTransformationBlock := [
			| offset scale |
			offset := array first negated @ array second negated.
			scale := (aBlElement width / array third) @
					   (aBlElement height / array fourth).
			aBlElement transformDo: [ :t |
				t
					translateBy: offset;
					topLeftOrigin;
					scaleBy: scale ] ].
		
		aBlElement
			whenLayoutedDoOnce: updateTransformationBlock.
		aBlElement
			addEventHandlerOn: BlElementExtentChangedEvent
			do: [ :evt | updateTransformationBlock value ] ]
]
