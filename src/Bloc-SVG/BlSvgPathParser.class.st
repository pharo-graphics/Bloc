"
I'm a parser for SVG path.

See: https://www.w3.org/TR/SVG2/paths.html
"
Class {
	#name : #BlSvgPathParser,
	#superclass : #Object,
	#instVars : [
		'absolute',
		'stream',
		'handler',
		'isFirstSegment',
		'selectorByLowercasedCommand'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlSvgPathParser class >> on: aStream handler: aHandler [

	^ self basicNew
		  initializeOnStream: aStream handler: aHandler;
		  yourself
]

{ #category : #initialization }
BlSvgPathParser >> initializeOnStream: aStream handler: aHandler [

	self initialize.
	
	stream := aStream.
	handler := aHandler.
	
	selectorByLowercasedCommand :=
		IdentityDictionary new
			at: $m put: #readMove;
			at: $l put: #readLine;
			at: $h put: #readHorizontalLine;
			at: $v put: #readVerticalLine;

			at: $c put: #readCubicBezier;
			at: $s put: #readSmoothCubicBezier;

			at: $q put: #readQuadraticBezier;
			at: $t put: #readSmoothQuadraticBezier;

			at: $a put: #readEllipticalArc;

			at: $z put: #readClosePath;
			yourself
]

{ #category : #'private - parsing' }
BlSvgPathParser >> nextNumber [
	"read the number from stream.
	or answer nil if not successfull"
	
"
<number> (real number value): The specification of real number values is different for property values than for XML attribute values.
❍ CSS2 [CSS2] states that a property value which is a <number> is specified in decimal notation (i.e., a <decimal-number>), which consists of either an <integer>, or an optional sign character followed by
zero or more digits followed by a dot (.) followed by one or more digits. Thus, for conformance with
CSS2, any property in SVG which accepts <number> values is specified in decimal notation only.
❍ For SVG's XML attributes, to provide as much scalability in numeric values as possible, real number
values can be provided either in decimal notation or in scientific notation (i.e., a <scientific-number>), which consists of a <decimal-number> immediately followed by the letter ''e'' or ''E'' immediately followed by an <integer>.
Unless stated otherwise for a particular attribute or property, a <number> has the capacity for at least a single- precision floating point number (see [ICC32]) and has a range (at a minimum) of -3.4e+38F to +3.4e+38F.
It is recommended that higher precision floating point storage and computation be performed on operations such as coordinate system transformations to provide the best possible precision and to prevent round-off errors.
Conforming High-Quality SVG Viewers are required to use at least double-precision floating point (see [ICC32]) for intermediate calculations on certain numerical operations.
Within the SVG DOM, a <number> is represented as a float or an SVGAnimatedNumber.
"
	
	| result sign esign pos int frac exponent |
	
	esign := sign := 1.
	pos := stream position.
	
	stream peek = $- ifTrue: [ sign := -1.  stream next ].

	int := self readInteger.
	
	stream peek = $. ifTrue: [
		stream next.
		frac := self readFraction.
	].
	
	(stream peek = $e or: [ stream peek = $E ]) ifTrue: [
		stream next.
		stream peek = $- ifTrue: [ esign := -1.  stream next ].

		exponent := self readInteger * esign ].
	
	"failed"
	(int isNil and: [ frac isNil ]) ifTrue: [ stream position: pos.  ^ nil ].
	
	int ifNil: [ int := 0 ].
	frac ifNil: [ frac := 0 ].
	exponent ifNil: [ exponent := 0 ].
	
	result :=  (int + frac * (10 raisedTo: exponent) * sign).
	
	result isFraction ifTrue: [  ^ result asFloat ] ifFalse: [ ^ result ]

]

{ #category : #'private - commands' }
BlSvgPathParser >> readClosePath [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataClosePathCommand"

	handler closePath
]

{ #category : #'private - parsing' }
BlSvgPathParser >> readCommandNamed: aCharacter [

	| command |
	command := aCharacter asLowercase.
	handler isAbsolute: aCharacter isUppercase.

	selectorByLowercasedCommand
		at: command
		ifPresent: [ :selector | self perform: selector ]
		ifAbsent: [
			self error: 'Invalid SVG command: ', aCharacter asString ]
]

{ #category : #'private - commands' }
BlSvgPathParser >> readCubicBezier [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataCubicBezierCommands"

	| p1 p2 p3 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	p3 := self readPoint.
	
	p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].

	handler cubicBezierVia: p1 and: p2 to: p3. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.
		p3 := self readPoint.

		p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].
		handler cubicBezierVia: p1 and: p2 to: p3. 
	] repeat.


]

{ #category : #'private - commands' }
BlSvgPathParser >> readEllipticalArc [ 
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataEllipticalArcCommands"

	[	| radiiPoint rotation large sweep pt |

		radiiPoint := self readPoint.
		radiiPoint ifNil: [ ^ self ].
		
		self skipBlanksAndComma.		
		rotation := self nextNumber.

		self skipBlanksAndComma.		
		large := self nextNumber.

		self skipBlanksAndComma.
		sweep := self nextNumber.
		
		pt := self readPoint.
		pt ifNil: [ self error: 'Invalid path data for elliptical arc segment' ].

		handler
			ellipticalArcRotation: radiiPoint abs
			xAxisRotation: rotation
			largeArcFlag: (large = 1)
			sweepFlag: (sweep = 1)
			to: pt.

	] repeat
]

{ #category : #'private - parsing' }
BlSvgPathParser >> readFraction [
"
read fraction, what is after the decimal point:

.12345


"
	| result mul |
	(stream atEnd or: [ stream peek isDigit not ]) ifTrue: [ ^ nil ].
	
	mul := 1/10. 
	result := 0.
	[ stream peek notNil and: [ stream peek isDigit ] ] whileTrue: [
		result := result + ( (stream next digitValue) * mul ).
		mul := mul / 10
	].
	^ result
]

{ #category : #'private - commands' }
BlSvgPathParser >> readHorizontalLine [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataLinetoCommands"

	| x |
	self skipBlanks.
	x := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment'   ].
	
	handler horizontalLineTo: x.
	
	[ self skipBlanks. x := self nextNumber. x notNil ]
		whileTrue: [ handler horizontalLineTo: x ]
]

{ #category : #'private - parsing' }
BlSvgPathParser >> readInteger [

	| result |
	(stream atEnd or: [ stream peek isDigit not ]) ifTrue: [ ^ nil ].
	
	result := 0.
	[ stream peek notNil and: [ stream peek isDigit ] ] whileTrue: [
		result := result * 10 + (stream next digitValue) ].
	^ result
]

{ #category : #'private - commands' }
BlSvgPathParser >> readLine [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataLinetoCommands"

	| pt |
	pt := self readPoint.
	
	pt ifNil: [ self error: 'point expected for line segment' ].
	
	handler lineTo: pt.
	
	[ pt := self readPoint. pt notNil ] whileTrue: [ handler lineTo: pt ]
]

{ #category : #'private - commands' }
BlSvgPathParser >> readMove [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataMovetoCommands"

	| pt |
	pt := self readPoint.
	pt ifNil: [ self error: 'a point expected following after M/m command'].
	
	handler moveTo: pt.
	
	[ pt := self readPoint. pt notNil ] whileTrue: [ handler lineTo: pt ]
]

{ #category : #'private - parsing' }
BlSvgPathParser >> readPoint [
	"A path data permits specifying points without comma separator."
	
	| x y pos |
	self skipBlanksAndComma.
	pos := stream position.
	x := self nextNumber ifNil: [ ^ nil ].
	
	self skipBlanksAndComma.
	
	y := self nextNumber ifNil: [ stream position: pos. ^ nil ].
	
	^ x @ y
]

{ #category : #'private - commands' }
BlSvgPathParser >> readQuadraticBezier [ 
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataQuadraticBezierCommands"

	| p1 p2 |
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
	
	handler quadraticBezierVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
		handler quadraticBezierVia: p1 to: p2. 
	] repeat
]

{ #category : #'private - commands' }
BlSvgPathParser >> readSmoothCubicBezier [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataCubicBezierCommands"

	| p1 p2 |
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].

	handler smoothCubicBezierVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].
		handler smoothCubicBezierVia: p1 to: p2. 
	] repeat
]

{ #category : #'private - commands' }
BlSvgPathParser >> readSmoothQuadraticBezier [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataQuadraticBezierCommands"

	| pt |
	pt := self readPoint.
	
	pt ifNil: [ self error: 'Invalid path data: 1 points expected for reflected quadratic bezier '].
	
	handler smoothQuadraticBezierTo: pt. 
	
	[ 
		(pt := self readPoint) ifNil: [ ^ self ].

		pt ifNil: [ self error: 'Invalid path data: 1 points expected for reflected quadratic bezier '].
		
		handler smoothQuadraticBezierTo: pt. 
	] repeat
]

{ #category : #API }
BlSvgPathParser >> readUpToEnd [

	[ self skipBlanks. stream atEnd ] whileFalse: [
		self readCommandNamed: stream next ]
]

{ #category : #'private - commands' }
BlSvgPathParser >> readVerticalLine [
	"See: https://www.w3.org/TR/SVG2/paths.html#PathDataLinetoCommands"

	| y |
	self skipBlanks.
	
	y := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment' ].	
	
	handler verticalLineTo: y.
	
	[ self skipBlanks. y := self nextNumber. y notNil ]
		whileTrue: [ handler verticalLineTo: y ]
]

{ #category : #'private - parsing' }
BlSvgPathParser >> skipBlanks [

	[ stream atEnd not and: [ stream peek isSeparator ] ]
		whileTrue: [ stream next ]
]

{ #category : #'private - parsing' }
BlSvgPathParser >> skipBlanksAndComma [
	[ stream atEnd not and: [
		stream peek isSeparator or: [
			stream peek = $, ] ] ]
				whileTrue: [ stream next ]
]
