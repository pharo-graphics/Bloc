Class {
	#name : #RdvNoteBlockDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #accessing }
RdvNoteBlockDemo >> animatedIcon [
<gtExample>
|icon e|
icon := BrGlamorousVectorIcons transcript asElement.
icon constraintsDo: [ :c | c accountTransformation ].

e := BlElement new
    background: Color white;
    border: (BlBorder paint: Color gray width: 1);
    geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
    padding: (BlInsets top: 5 left: 10 bottom: 5 right: 10);
    layout: (BlZoomableLayout new addLayout: BlFrameLayout new; defaultScale: 2; animationDuration: 1 second);
    constraintsDo: [ :c |
        c vertical fitContent.
        c horizontal fitContent ];
    addChild: icon;
    yourself.
 ^e
]

{ #category : #accessing }
RdvNoteBlockDemo >> animtedBackground [
<gtExample>
|element animation|
	
	element := BlElement new.
element size: 50@50.

animation := BlNumberTransition new
    from: 0;
    to: 1;
    by: 0.5;
    beInfinite;
    duration: 3 seconds;
    onStepDo: [ :aValue :anElement |
        aValue < 0.5
            ifTrue: [ anElement background: Color red ]
            ifFalse: [ anElement background: Color blue ] ].

element addAnimation: animation.
^element
]

{ #category : #accessing }
RdvNoteBlockDemo >> bigAdaptableText [
<gtExample>
^(BlTextElement new text: 'hello' asRopedText) asScalableElement.
]

{ #category : #'accessing - demo' }
RdvNoteBlockDemo >> blAnnulusExample [

	<bookExample>
	| tagDict pingCount piAngles fromAngle chart centerLabel element |
	tagDict := {
		           ('A' -> 10).
		           ('B' -> 20).
		           ('C' -> 30).
		           ('D' -> 40) } asDictionary.

	pingCount := tagDict values sum.
	piAngles := tagDict associations collect: [ :assoc |
		            assoc key -> (assoc value / pingCount * 360) ].

	fromAngle := 0.

	chart := BlElement new size: 700 @ 700.

	centerLabel := BlElement new position: 300 @ 300.

	piAngles do: [ :el |
		| start end sec label |
		start := fromAngle.
		end := fromAngle + el value.
		sec := BlAnnulusSector new
			       startAngle: start;
			       endAngle: end;
			       innerRadius: 0.5.

		label := BlTextElement new text: el key asRopedText.
		label position: 300 @ 300.

		fromAngle := el value + fromAngle.

		element := BlElement new
			           background: (BlColorPaint color: Color random);
			           size: 400 @ 400;
			           geometry: sec.

		element position: 100 @ 100.

		element
			addEventHandlerOn: BlMouseEnterEvent
			do: [ chart addChild: label as: #centerLabel ].

		element
			addEventHandlerOn: BlMouseLeaveEvent
			do: [ chart removeChildWithId: #centerLabel ].

		chart addChild: element ].

	^ chart
]

{ #category : #'accessing - demo' }
RdvNoteBlockDemo >> blAnnulusExample2 [
<bookExample>
"you can click on part of the circle to put some action"
^BlElement new
    size: 400@400;
    addChildren: ({
        (-90 to: 30) -> (Color r: 111 g: 91 b: 149 range: 255).
        (30 to: 60) -> (Color r: 152 g: 138 b: 193 range: 255).
        (60 to: 120) -> (Color r: 237 g: 150 b: 54 range: 255).
        (120 to: 150) -> (Color r: 243 g: 189 b: 55 range: 255).
        (150 to: 230) -> (Color r: 36 g: 174 b: 226 range: 255).
        (230 to: 270) -> (Color r: 99 g: 197 b: 198 range: 255)
    } collect: [ :each |
        BlElement new
            when: BlClickEvent do: [:e | e target phlow spawnObject: each key ];
            geometry: ((BlAnnulusSector new startAngle: each key first; endAngle: each key last));
            background: each value;
            constraintsDo: [ :c |
                c horizontal matchParent.
                c vertical matchParent ] ])
]

{ #category : #accessing }
RdvNoteBlockDemo >> createSpace [
	"This is a new method"
<gtExample>	
	| aSpace |
	
	aSpace := BlSpace new
		addChild: self helloWorldScene;
		extent: 800@600;
		title: 'Hello World'.

	^ aSpace show
]

{ #category : #'accessing - demo' }
RdvNoteBlockDemo >> donut [
<bookExample>
^BlElement new
    size: 400@400;
    addChildren: ({
        (-90 to: 30) -> (Color r: 111 g: 91 b: 149 range: 255).
        (30 to: 60) -> (Color r: 152 g: 138 b: 193 range: 255).
        (60 to: 120) -> (Color r: 237 g: 150 b: 54 range: 255).
        (120 to: 150) -> (Color r: 243 g: 189 b: 55 range: 255).
        (150 to: 230) -> (Color r: 36 g: 174 b: 226 range: 255).
        (230 to: 270) -> (Color r: 99 g: 197 b: 198 range: 255)
    } collect: [ :each |
        BlElement new
            geometry: ((BlAnnulusSector new startAngle: each key first; endAngle: each key last));
            background: each value;
            constraintsDo: [ :c |
                c horizontal matchParent.
                c vertical matchParent ] ])
]

{ #category : #'accessing - demo' }
RdvNoteBlockDemo >> eventExample [
<bookExample>
	"This is a new method"
|toto|
toto := BlDevElement new size:200@200;
geometry:( BlPolygon
		vertices:
			{(100 @ 50).
			(115 @ 90).
			(150 @ 90).
			(125 @ 110).
			(135 @ 150).
			(100 @ 130).
			(65 @ 150).
			(75 @ 110).
			(50 @ 90).
			(85 @ 90)});
background: (Color pink alpha:0.2);
border: (BlBorder paint: Color orange width: 4);
"layout: BlLinearLayout horizontal alignCenter;"
"constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];"
outskirts: BlOutskirts outside.

toto when: BlMouseEnterEvent do: [ :anEvent |
		anEvent consumed: true.
		toto background: (Color red alpha:0.2) ].
		
 toto when: BlMouseLeaveEvent do: [ :anEvent |
		anEvent consumed: true.
		toto background: (Color blue alpha:0.2) ].
^toto
]

{ #category : #accessing }
RdvNoteBlockDemo >> eventExampleMouseMove [

	<gtExample>
	| surface elt |
	elt := BlElement new
		       size: 20 @ 20;
		       geometry: (BlPolygon vertices: {
						        (10 @ 5).
						        (11.5 @ 9).
						        (15 @ 9).
						        (12.5 @ 11).
						        (13.5 @ 15).
						        (10 @ 13).
						        (6.5 @ 15).
						        (7.5 @ 11).
						        (5 @ 9).
						        (8.5 @ 9) });
		       background: (Color red alpha: 0.5);
		       border: (BlBorder paint: Color blue width: 1).

	surface := BlElement new
		           size: 400 @ 400;
		           geometry: BlSquare new;
		           background: (Color pink alpha: 0.2);
		           border: (BlBorder paint: Color orange width: 4).

	surface addChild: elt.
	elt position: -20 @ -20.

	surface when: BlMouseMoveEvent do: [ :anEvent |
		anEvent consumed: true.
		elt position: anEvent localPosition + (10 @ 10) ].

	surface when: BlMouseLeaveEvent do: [ :anEvent |
		anEvent consumed: true.
		elt position: -20 @ -20 ].
	^ surface
]

{ #category : #accessing }
RdvNoteBlockDemo >> eventStyleExample [
<gtExample>
|toto|
toto := BlElement new size: 200 @ 200.
toto styles
	default: [ :aStyle | 
		aStyle
			geometry: (BlPolygon
					vertices: {100 @ 50.
							115 @ 90.
							150 @ 90.
							125 @ 110.
							135 @ 150.
							100 @ 130.
							65 @ 150.
							75 @ 110.
							50 @ 90.
							85 @ 90});
			background: (Color pink alpha: 0.2);
			border: (BlBorder paint: Color black width: 1) ];
		hovered:[ :aStyle | aStyle
			background: (Color blue alpha: 0.2);
			border: (BlBorder paint: Color purple width: 1) ].
			
^toto
]

{ #category : #accessing }
RdvNoteBlockDemo >> helloWorldScene [
	<gtExample>
	| aContainer |
	
	aContainer := BrVerticalPane new
		matchParent;
		alignCenter.
		
	aContainer addChild: (BrLabel new
		aptitude: (BrGlamorousLabelAptitude new fontSize: 30);
		text: 'Hello world!').
		
	^ aContainer
]

{ #category : #accessing }
RdvNoteBlockDemo >> iconScaleToFitElement [
<gtExample>
|icon scaledIcon e|
icon := BrGlamorousVectorIcons transcript asElement.
scaledIcon := icon asScalableElement
    scaleStrategy: (BlScalableFixedStrategy zoom: 2);
    constraintsDo: [ :c |
        c horizontal fitContent.
        c vertical fitContent ].
    
e := BlElement new
    background: Color white;
    border: (BlBorder paint: Color gray width: 1);
    geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
    padding: (BlInsets top: 5 left: 10 bottom: 5 right: 10);
    layout: BlFrameLayout new;
    constraintsDo: [ :c |
        c vertical fitContent.
        c horizontal fitContent ];
    addChild: scaledIcon;
    yourself.
    
^e
]

{ #category : #'accessing - demo' }
RdvNoteBlockDemo >> rainbow [

	<bookExample>
	| root stroke wh colors a |
	root := BlElement new
		        size: (wh := 640 @ 480);
		        background: Color black.
	stroke := BlBorder paint: Color black.

	"Draw a rainbow"
	colors := #( #red #orange #yellow #green #blue #purple ).
	(1 to: colors size) do: [ :i |
		| r el |
		r := colors size + 1 - i * 400 ** 0.8.
		el := BlElement new
			      size: r @ r;
			      geometry: (BlAnnulusSector new
					       startAngle: 180;
					       endAngle: 360);
			      background: (Color named: (colors at: i));
			      border: stroke;
			      position: root extent + wh - (r @ r) / 2 + (0 @ 120).
		root addChild: el ].

	"Draggable card that says 'Rainbow!'"
	a := BlElement new
		     geometry: BlRectangleGeometry new;
		     size: 65 @ 24;
		     background: Color white;
		     border: stroke;
		     addEventHandlerOn: BlMouseOverEvent
		     do: [ :e | a background: Color lightGray ];
		     addEventHandlerOn: BlMouseOutEvent
		     do: [ :e | a background: Color white ];
		     addEventHandler: BlPullHandler new disallowOutOfBounds;
		     addChild: (BlTextElement new
				      position: 5 @ 5;
				      text: ('Rainbow!' asRopedText attributes:
							       { (BlTextForegroundAttribute paint: Color black) })).

	root addChild: a.
	^ root
]
