Class {
	#name : #BlSvgPathBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'commands',
		'segments',
		'absolute',
		'stream'
	],
	#category : #'Bloc-Geometry-SVG'
}

{ #category : #'instance creation' }
BlSvgPathBuilder class >> fromStream: aStream [
	^ self new fromStream: aStream
]

{ #category : #commands }
BlSvgPathBuilder >> A [
	self absolute; ellipticalArc
]

{ #category : #commands }
BlSvgPathBuilder >> C [

	^ self absolute; cubicBezier 
]

{ #category : #commands }
BlSvgPathBuilder >> H [
	self absolute; hLineTo 
]

{ #category : #commands }
BlSvgPathBuilder >> L [
	self absolute; lineTo.
]

{ #category : #commands }
BlSvgPathBuilder >> M [
	"move-to absolute"
	" 
		Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. 
		If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates. 
		If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.
	
	"
	self absolute; moveTo.

]

{ #category : #commands }
BlSvgPathBuilder >> Q [
	self absolute; quadraticBezier
]

{ #category : #commands }
BlSvgPathBuilder >> S [
	self absolute; reflectedCubicBezier
]

{ #category : #commands }
BlSvgPathBuilder >> T [
	self absolute; reflectedQuadraticBezier
]

{ #category : #commands }
BlSvgPathBuilder >> V [
	self absolute; vLineTo 
]

{ #category : #commands }
BlSvgPathBuilder >> Z [
	self close
]

{ #category : #commands }
BlSvgPathBuilder >> a [
	self relative; ellipticalArc
]

{ #category : #'api - builder' }
BlSvgPathBuilder >> absolute [
	absolute := true
]

{ #category : #adding }
BlSvgPathBuilder >> addSegment: aPathSegment [
	segments add: aPathSegment
]

{ #category : #accessing }
BlSvgPathBuilder >> bbox [
	^ 100@100
]

{ #category : #commands }
BlSvgPathBuilder >> c [

	^ self relative; cubicBezier 
]

{ #category : #'api - builder' }
BlSvgPathBuilder >> close [
	self addSegment: (BlSvgPathCloseSegment absolute: absolute)
]

{ #category : #accessing }
BlSvgPathBuilder >> commands [
	<return: #Dictionary>
	
	^ commands
]

{ #category : #operations }
BlSvgPathBuilder >> cubicBezier [


"
C/c (x1 y1 x2 y2 x y)+

Draws a cubic Bézier curve from the current point to (x,y) using (x1,y1) as the control point at the beginning of the curve and (x2,y2) as the control point at the end of the curve. 
C (uppercase) indicates that absolute coordinates will follow; c (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. 
At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier.
"
	| p1 p2 p3 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	p3 := self readPoint.
	
	p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].

	self curveVia: p1 and:  p2 to: p3. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.
		p3 := self readPoint.

		p3 ifNil: [ self error: 'Invalid path data: 3 points expected for cubic bezier '].
		self curveVia: p1 and:  p2 to: p3. 
	] repeat.


]

{ #category : #'api - builder' }
BlSvgPathBuilder >> curveVia: aPoint and: aPoint2 to: aPoint3 [ 
	self addSegment: ((BlSvgPathCubicBezierSegment absolute: absolute) firstViaPoint: aPoint; secondViaPoint: aPoint2; curveTo: aPoint2)
]

{ #category : #'api - builder' }
BlSvgPathBuilder >> curveVia: aPoint to: aPoint2 [ 
	self addSegment: ((BlSvgPathQuadraticBezierSegment absolute: absolute) viaPoint: aPoint; curveTo: aPoint2)
]

{ #category : #operations }
BlSvgPathBuilder >> ellipticalArc [ 


"
A (absolute) a (relative)

elliptical arc
(rx ry x-axis-rotation large-arc-flag sweep-flag x y)+
Draws an elliptical arc from the current point to (x, y). The size and orientation of the ellipse are defined by two radii (rx, ry) and an x-axis-rotation, which indicates how the ellipse as a whole is rotated relative to the current coordinate system. The center (cx, cy) of the ellipse is calculated automatically to satisfy the constraints imposed by the other parameters. large-arc-flag and sweep- flag contribute to the automatic calculations and help determine how the arc is drawn.
"
	| r xrot large sweep pt |
	
	[
	r := self readPoint.
	r ifNil: [ ^ self ].
	
	self skipBlanksAndComma.
	
	xrot := self nextNumber.

	self skipBlanksAndComma.
	
	large := self nextNumber.

	self skipBlanksAndComma.

	sweep := self nextNumber.
	
	pt := self readPoint.
	
	pt ifNil: [ self error: 'Invalid path data for elliptical arc segment'].

	self ellipticalArc: r xrot: xrot large: large sweep: sweep to: pt.
	] repeat.


]

{ #category : #'api - builder' }
BlSvgPathBuilder >> ellipticalArc: r xrot: xrot large: large sweep: sweep to: pt [

	self halt
]

{ #category : #initialization }
BlSvgPathBuilder >> fromStream: aStream [
	stream := aStream.
	self parsePathCommands
]

{ #category : #'gt-extension' }
BlSvgPathBuilder >> gtCommandsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Commands';
		priority: 2;
		items: [ self commands associations ];
		column: 'Letter' item: [ :each | each key ];
		column: 'Command' item: [ :each | each value ];
		send: #value
]

{ #category : #'gt-extension' }
BlSvgPathBuilder >> gtSegmentsFor: aView [
	<gtView>

	^ aView list
		title: 'Segments';
		priority: 1;
		items: [ self segments ]
]

{ #category : #commands }
BlSvgPathBuilder >> h [
	self relative; hLineTo 
]

{ #category : #operations }
BlSvgPathBuilder >> hLineTo [
"
H (absolute) h (relative)

x +
Draws a horizontal line from the current point (cpx, cpy) to (x, cpy). H (uppercase) indicates that absolute coordinates will follow; h (lowercase) indicates that relative coordinates will follow. Multiple x values can be provided (although usually this doesn't make sense). At the end of the command, the new current point becomes (x, cpy) for the final value of x.
"
	| x |

	self skipBlanks.
	x := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment'   ].
	
	self lineTo: x @ 0.
	
	[ self skipBlanks. x := self nextNumber. x notNil ]
		whileTrue: [ self lineTo: x @ 0 ]
]

{ #category : #initialization }
BlSvgPathBuilder >> initialize [
	super initialize.

	segments := OrderedCollection new.
	
	commands := IdentityDictionary new.
	"absolute commands"
	commands at: #A put: [ self A ].
	commands at: #C put: [ self C ].
	commands at: #H put: [ self H ].
	commands at: #L put: [ self L ].
	commands at: #M put: [ self M ].
	commands at: #Q put: [ self Q ].
	commands at: #S put: [ self S ].
	commands at: #T put: [ self T ].
	commands at: #V put: [ self V ].
	commands at: #Z put: [ self Z ].
	"relative commands"
	commands at: #a put: [ self a ].
	commands at: #c put: [ self c ].
	commands at: #h put: [ self h ].
	commands at: #l put: [ self l ].
	commands at: #m put: [ self m ].
	commands at: #q put: [ self q ].
	commands at: #s put: [ self s ].
	commands at: #t put: [ self t ].
	commands at: #v put: [ self v ].
	commands at: #z put: [ self z ]
]

{ #category : #commands }
BlSvgPathBuilder >> l [
	self relative; lineTo.
]

{ #category : #operations }
BlSvgPathBuilder >> lineTo [
" 
L (absolute) l (relative)
lineto

(x y)+
Draw a line from the current point to the given (x,y) coordinate which becomes the new current point. L (uppercase) indicates that absolute coordinates will follow; l (lowercase) indicates that relative coordinates will follow. A number of coordinates pairs may be specified to draw a polyline. At the end of the command, the new current point is set to the final set of coordinates provided.
"

	| pt |
	pt := self readPoint.
	
	pt ifNil: [ self error: 'point expected for line segment' ].
	
	self lineTo: pt.
	
	[ pt := self readPoint. pt notNil ] whileTrue: [ self lineTo: pt ]
]

{ #category : #'api - builder' }
BlSvgPathBuilder >> lineTo: aPoint [
	self addSegment: ((BlSvgPathLineSegment absolute: absolute) lineTo: aPoint)
]

{ #category : #commands }
BlSvgPathBuilder >> m [
	"move-to relative"
	" 
		Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. 
		If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates. 
		If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.
	
	"
	| pt reset |

	pt := self readPoint.
	pt ifNil: [ self error: 'a point expected following after M/m command'].

	segments isEmpty ifTrue: [ 
			self absolute; moveTo: pt; relative ] 
		ifFalse: [ self relative; moveTo: pt ].

	[ pt := self readPoint. pt notNil ] whileTrue: [ self lineTo: pt ]
]

{ #category : #operations }
BlSvgPathBuilder >> moveTo [
	"move-to"
	" 
		Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. 
		If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates. 
		If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.
	
	"
	| pt |

	pt := self readPoint.
	pt ifNil: [ self error: 'a point expected following after M/m command'].
	
	self moveTo: pt.
	
	[ pt := self readPoint. pt notNil ] whileTrue: [ self lineTo: pt ]

]

{ #category : #'api - builder' }
BlSvgPathBuilder >> moveTo: aPoint [
	self addSegment: ((BlSvgPathMoveSegment absolute: absolute) moveTo: aPoint)
]

{ #category : #'private - parsing' }
BlSvgPathBuilder >> nextNumber [
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
	
	| result char sign esign pos int frac exponent |
	
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

{ #category : #'private - parsing' }
BlSvgPathBuilder >> parsePathCommands [
	[ self skipBlanks. stream atEnd ]
		whileFalse: [ self performCommandNamed: stream next asString asSymbol ]
]

{ #category : #commands }
BlSvgPathBuilder >> performCommandNamed: aSymbol [
	self commands
		at: aSymbol
		ifPresent: [ :aCommand | aCommand value ]
		ifAbsent: [ self error: 'Invalid command - ', aSymbol asString ]
]

{ #category : #commands }
BlSvgPathBuilder >> q [
	self relative; quadraticBezier
]

{ #category : #operations }
BlSvgPathBuilder >> quadraticBezier [ 


"
Q/q (x1 y1 x y)+

Draws a quadratic Bézier curve from the current point to (x,y) using (x1,y1) as the control point. Q (uppercase) indicates that absolute coordinates will follow; q (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier."
	| p1 p2 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
	
	self curveVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for quadratic bezier '].
		self curveVia: p1 to: p2. 
	] repeat.


]

{ #category : #'private - parsing' }
BlSvgPathBuilder >> readFraction [
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

{ #category : #'private - parsing' }
BlSvgPathBuilder >> readInteger [
	| result |
	(stream atEnd or: [ stream peek isDigit not ]) ifTrue: [ ^ nil ].
	
	result := 0.
	[ stream peek notNil and: [ stream peek isDigit ] ] whileTrue: [
		result := result * 10 + (stream next digitValue)
	].
	^ result
]

{ #category : #'private - parsing' }
BlSvgPathBuilder >> readPoint [
	" A path data permits specifying points without comma separator "
	| x y pos |
	self skipBlanksAndComma.
	pos := stream position.
	x := self nextNumber ifNil: [ ^ nil ].
	
	self skipBlanksAndComma.
	
	y := self nextNumber ifNil: [ stream position: pos. ^ nil ].
	
	^ x @ y
]

{ #category : #operations }
BlSvgPathBuilder >> reflectedCubicBezier [

"
S/s (x2 y2 x y)+

cubic Bézier curve from the current point to (x,y). The first control point is assumed to be the reflection of the second control point on the previous command relative to the current point. (If there is no previous command or if the previous command was not an C, c, S or s, assume the first control point is coincident with the current point.) (x2,y2) is the second control point (i.e., the control point at the end of the curve). S (uppercase) indicates that absolute coordinates will follow; s (lowercase) indicates that relative coordinates will follow. Multiple sets of coordinates may be specified to draw a polybézier. At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier.
"
	| p1 p2 |
	
	p1 := self readPoint.
	p2 := self readPoint.
	
	p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].

	self reflectedCurveVia: p1 to: p2. 
	
	[ 
		(p1 := self readPoint) ifNil: [ ^ self ].
		p2 := self readPoint.

		p2 ifNil: [ self error: 'Invalid path data: 2 points expected for reflected cubic bezier '].
		self reflectedCurveVia: p1 to: p2. 
	] repeat.


]

{ #category : #'api - builder' }
BlSvgPathBuilder >> reflectedCurveTo: aPoint [


	self halt
]

{ #category : #'api - builder' }
BlSvgPathBuilder >> reflectedCurveVia: aPoint to: aPoint2 [ 


	self halt
]

{ #category : #operations }
BlSvgPathBuilder >> reflectedQuadraticBezier [
	
	
	"
T/t (x y)+

Draws a quadratic Bézier curve from the current point to (x,y). The control point is assumed to be the reflection of the control point on the previous command relative to the current point. (If there is no previous command or if the previous command was not a Q, q, T or t, assume the control point is coincident with the current point.) T (uppercase) indicates that absolute coordinates will follow; t (lowercase) indicates that relative coordinates will follow. At the end of the command, the new current point becomes the final (x,y) coordinate pair used in the polybézier."
	| pt |

	pt := self readPoint.
	
	pt ifNil: [ self error: 'Invalid path data: 1 points expected for reflected quadratic bezier '].
	
	self reflectedCurveTo: pt. 
	
	[ 
		(pt := self readPoint) ifNil: [ ^ self ].

		pt ifNil: [ self error: 'Invalid path data: 1 points expected for reflected quadratic bezier '].
		
		self reflectedCurveTo: pt. 
	] repeat.


]

{ #category : #'api - builder' }
BlSvgPathBuilder >> relative [
	absolute := false
]

{ #category : #commands }
BlSvgPathBuilder >> s [
	self relative; reflectedCubicBezier
]

{ #category : #accessing }
BlSvgPathBuilder >> segments [
	^ segments
]

{ #category : #'private - parsing' }
BlSvgPathBuilder >> skipBlanks [
	[ stream atEnd not and: [ stream peek isSeparator ] ] whileTrue: [ stream next ].
]

{ #category : #'private - parsing' }
BlSvgPathBuilder >> skipBlanksAndComma [
	[ stream atEnd not and: [ stream peek isSeparator or: [stream peek =$,]] ] whileTrue: [ stream next ].
]

{ #category : #accessing }
BlSvgPathBuilder >> stream [
	^ stream
]

{ #category : #commands }
BlSvgPathBuilder >> t [
	self relative; reflectedQuadraticBezier
]

{ #category : #commands }
BlSvgPathBuilder >> v [
	self relative; vLineTo 
]

{ #category : #operations }
BlSvgPathBuilder >> vLineTo [
"
V (absolute) v (relative)

Draws a vertical line from the current point (cpx, cpy) to (cpx, y). V (uppercase) indicates that absolute coordinates will follow; v (lowercase) indicates that relative coordinates will follow. Multiple y values can be provided (although usually this doesn't make sense). At the end of the command, the new current point becomes (cpx, y) for the final value of y."

	| y |
	
	self skipBlanks.
	y := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment'   ].
	self lineTo: 0 @ y.
	[ self skipBlanks. y := self nextNumber. y notNil ]
		whileTrue: [ self lineTo: 0 @ y ]
]

{ #category : #commands }
BlSvgPathBuilder >> z [
	self close
]
