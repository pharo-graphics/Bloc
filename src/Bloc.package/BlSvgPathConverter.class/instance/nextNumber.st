parsing-public
nextNumber
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
