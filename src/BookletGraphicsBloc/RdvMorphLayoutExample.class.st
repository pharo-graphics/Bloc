Class {
	#name : #RdvMorphLayoutExample,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #accessing }
RdvMorphLayoutExample >> centeredMorph1 [
	<script: 'self new centeredMorph1'>
	
	| myLayoutMorph m |
	myLayoutMorph := Morph new.
	myLayoutMorph layoutPolicy: TableLayout new.	"center submorphs"
	myLayoutMorph listCentering: #center.
	myLayoutMorph wrapCentering: #center.

	myLayoutMorph width: 320.
	myLayoutMorph height: 240.
	myLayoutMorph color: Color white darker.

	m := Morph new color: Color red.
	m width: myLayoutMorph width - 40.
	m height: myLayoutMorph height - 40.


	myLayoutMorph addMorph: m.
	myLayoutMorph openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> centeredMorph2 [
	<script: 'self new centeredMorph2'>
	| myLayoutMorph m |
	myLayoutMorph := Morph new.
	myLayoutMorph layoutPolicy: TableLayout new.
	myLayoutMorph color: Color gray.

	myLayoutMorph listDirection: #leftToRight.
	myLayoutMorph
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
	myLayoutMorph layoutInset: 20.

	m := Morph new color: Color green darker.
	m width: 300.
	m height: 200.

	myLayoutMorph addMorph: m.
	myLayoutMorph openInHand
]

{ #category : #accessing }
RdvMorphLayoutExample >> largeLayoutMorph1 [
	"Parameters"

	<script: 'self new largeLayoutMorph1'>
	| slideExtent slideColor1 xLeft xRight yContent createSlideBlk slide container btn1 btn2 btnPanel |
	"--------------------------------------------------------------------"
	slideExtent := 420 @ 320.
	slideColor1 := Color white.	"fontName := 'BitstreamVeraSans'."	"titleFontPointSize := 24."
	xLeft := 20.
	xRight := 140.
	yContent := 80.	"--------------------------------------------------------------------"	"createSlideBlocka block is like a function definition assigned to an instance variable. 
The block created here takes two parameters
    aColor    
    aTitleString

To activate the block send the message #value:value to it. 

For example     
createSlideBlk value: Color yellow value: 'Presentations made easy'.

This will actually execute the code and thus build a slide morph which is a RectangleMorphwith a property #isSlide set to true.

The result of the block is the  object returned by the last statement.
In this case 'slide'."	"DEFINITION OF THE BLOCK"
	createSlideBlk := [ :aColor :aTitleString | 
		| titleTextMorph |
		slide := Morph new.
		slide extent: slideExtent.
		slide color: aColor.
		slide position: 0 @ 10.
		slide borderWidth: 0.
		slide setProperty: #isSlide toValue: true.

		titleTextMorph := TextMorph new.
		titleTextMorph contentsWrapped: aTitleString.	"NO setting of font size in this test"	"titleTextMorph fontName: fontName pointSize: titleFontPointSize."
		titleTextMorph extent: slideExtent x @ 50.
		titleTextMorph position: 20 @ 20.
		slide addMorph: titleTextMorph.
		slide position: 0 @ 20 ].	"EXECUTING THE CODE IN THE BLOCK"
	slide := createSlideBlk value: slideColor1 value: 'TableLayout listCentering'.


	container := Morph new.
	container layoutPolicy: TableLayout new.
	container listDirection: #bottomToTop.
	container hResizing: #rigid.
	container height: 240.
	container hResizing: #shrinkWrap.
	container layoutInset: 10.
	container cellInset: 2.
	container listCentering: #justified.
	container addMorph: (Morph new color: Color red).
	container
		addMorph: (Morph new
				color: Color yellow;
				width: 80).
	container addMorph: (Morph new color: Color green).



	btn1 := SimpleButtonMorph new.
	btn1 hResizing: #spaceFill.
	btn1 target: container.
	btn1 label: 'listCentering: #center'.
	btn1 actionSelector: #listCentering:.
	btn1 arguments: (Array with: #center).
	btn2 := SimpleButtonMorph new.
	btn2 hResizing: #spaceFill.
	btn2 target: container.
	btn2 label: 'listCentering: #justified'.
	btn2 actionSelector: #listCentering:.
	btn2 arguments: (Array with: #justified).

	btnPanel := Morph new.
	btnPanel height: 220.
	btnPanel color: slideColor1.
	btnPanel layoutPolicy: TableLayout new.
	btnPanel listDirection: #topToBottom.
	btnPanel width: 220.
	btnPanel borderWidth: 0.
	btnPanel listCentering: #justified.
	btnPanel layoutInset: 0.
	btnPanel cellInset: 0.
	btnPanel addMorphBack: btn1.
	btnPanel addMorphBack: btn2.

	container position: xLeft @ yContent.
	slide addMorph: container.
	btnPanel position: xRight @ yContent.
	slide addMorph: btnPanel.
	slide openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> tableLayoutMorph [
	<script: 'self new tableLayoutMorph'>
	|  m |
	m := Morph new.
	m layoutPolicy: TableLayout new.
	m listDirection: #leftToRight.
	m
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
	m layoutInset: 2.
	m cellInset: 12.
	8 timesRepeat: [ m addMorph: (Morph new color: Color blue) ].
	m openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> tableLayoutMorph1 [
	"Parameters"

	<script: 'self new tableLayoutMorph1'>
	| slide container btn1 btn2 btn3 btn4 |
	slide := Morph new extent: 500 @ 300.
	slide color: Color yellow.
	container := Morph new.
	container width: 3 * 50 + 20.
	container height: 3 * 50 + 20.
	container color: Color red.

	container layoutPolicy: TableLayout new.
	container layoutInset: 10.

	container listDirection: #leftToRight.

	container wrapCentering: #topLeft.
	container wrapDirection: #topToBottom.


	1
		to: 9
		do: [ :i | 
			| cell |
			cell := Morph new.
			cell height: 50.
			cell color: Color white.
			cell width: 50.
			cell borderWidth: 1.
			cell addMorph: (StringMorph contents: i printString).
			container addMorphBack: cell ].

	btn1 := SimpleButtonMorph new.
	btn1 target: container.
	btn1 label: 'listDirection: #leftToRight'.
	btn1 actionSelector: #listDirection:.
	btn1 arguments: (Array with: #leftToRight).
	btn1 position: 250 @ 50.


	btn2 := SimpleButtonMorph new.
	btn2 target: container.
	btn2 label: 'listDirection: #rightToLeft'.
	btn2 actionSelector: #listDirection:.
	btn2 arguments: (Array with: #rightToLeft).
	btn2 position: 250 @ 100.

	btn3 := SimpleButtonMorph new.
	btn3 target: container.
	btn3 label: 'listDirection: #topToBottom'.
	btn3 actionSelector: #listDirection:.
	btn3 arguments: (Array with: #topToBottom).
	btn3 position: 250 @ 150.

	btn4 := SimpleButtonMorph new.
	btn4 target: container.
	btn4 label: 'listDirection: #bottomToTop'.
	btn4 actionSelector: #listDirection:.
	btn4 arguments: (Array with: #bottomToTop).
	btn4 position: 250 @ 200.

	container position: 50 @ 50.

	slide addMorph: container.
	slide addMorph: btn1.
	slide addMorph: btn2.
	slide addMorph: btn3.
	slide addMorph: btn4.

	slide openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> tableLayoutMorph2 [
	<script: 'self new tableLayoutMorph2'>
	|  m |
	m := Morph new color: Color cyan.
	m layoutPolicy: TableLayout new.
	m listDirection: #leftToRight.
	m
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
	m layoutInset: 2.
	m cellInset: 12.
	8 timesRepeat: [ m addMorph: (Morph new color: Color blue) ].
	m openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> tableLayoutMorph3 [
	<script: 'self new tableLayoutMorph3'>
	| m |
	m := Morph new color: Color cyan.
	m layoutPolicy: TableLayout new.
	m listDirection: #leftToRight.
	m vResizing: #shrinkWrap.
	m wrapDirection: #topToBottom.
	m width: 200.
	m layoutInset: 2.
	m cellInset: 12.
	8 timesRepeat: [ m addMorph: (Morph new color: Color orange) ].
	m openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> tableLayoutMorph4 [
	<script: 'self new tableLayoutMorph4'>
	| m |
	m := Morph new color: Color cyan.
	m layoutPolicy: TableLayout new.
	m listDirection: #leftToRight.	"If you omit this expression you get the default "	"m listDirection: #topToBottom."
	m hResizing: #shrinkWrap.
	m vResizing: #shrinkWrap.

	m
		addMorph: (EllipseMorph new
				extent: 40 @ 40;
				color: Color red).
	m
		addMorph: (EllipseMorph new
				extent: 50 @ 50;
				color: Color yellow).
	m
		addMorph: (EllipseMorph new
				extent: 60 @ 60;
				color: Color green).
	m
		addMorph: (EllipseMorph new
				extent: 70 @ 70;
				color: Color blue).
	m openInWorld
]

{ #category : #accessing }
RdvMorphLayoutExample >> textLayoutMorph1 [
	<script: 'self new textLayoutMorph1'>
	| r e s b |
	r := Morph new.
	r color: Color gray.
	r position: 10 @ 10.
	r extent: 150 @ 200.
	r name: 'background'.
	r openInWorld.

	r layoutPolicy: TableLayout new.	"lay out contents as a table"
	r listDirection: #topToBottom.	"how we want to place the contents"
	r listCentering: #topLeft.	"start list at the top"
	r wrapCentering: #center.	"each item is in the center"
	e := EllipseMorph new.
	r addMorph: e.

	s := Morph new.
	s borderWidth: 1.
	s color: Color blue twiceDarker.
	r addMorph: s.	"note that the new item goes at the top"

	b := SimpleButtonMorph new.
	b
		color: Color red;
		label: 'remove';
		target: r;
		actionSelector: #delete;
		setBalloonText: 'click to remove the background rectangle and contents'.
	r addMorph: b.

	r cellInset: 2 @ 5.	"controls distance between content elements. Note that the inset can be a Number, a Point or even a Rectangle"

	r hResizing: #shrinkWrap.	"try it and see!"
	r layoutInset: 4 @ 8.	"that was a bt too cramped. Note that the inset can be a Number, a Point or even a Rectangle"
	r vResizing: #shrinkWrap	"Now we are done"
]
