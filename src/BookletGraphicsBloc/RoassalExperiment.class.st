Class {
	#name : #RoassalExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-roassal'
}

{ #category : #'as yet unclassified' }
RoassalExperiment >> barAndLineChartExample [

	<bookExample>
	| c x y |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.

	c addPlot: (RSBarPlot new x: x y: y).
	c addPlot: (RSLinePlot new
			 x: x y: y;
			 color: Color red).

	c addDecoration: RSHorizontalTick new asFloat.
	c addDecoration: (RSVerticalTick new
			 numberOfTicks: 10;
			 asFloat).
	c xlabel: 'X Axis'.
	c ylabel: 'Y Axis'.
	c title: 'Bar char'.
	c build.
	^c canvas
]

{ #category : #'as yet unclassified' }
RoassalExperiment >> barChartExample1 [
	<bookExample>
| c p p2 p3 p4 x y size |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	
	
	c := RSChart  new.
	c extent: 200@200.
	c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 10).
	c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 10).
	
	size := 4.
	
	p := RSBarPlot new x: x y: #(1 2 3 4 5 6 7 8 9 10).
	p barSize: size.
	p color: Color red.
	p gapRatio: 0.5.
	p barOffset: size * -1.
	
	p2 := RSBarPlot new x: x y: #(2 4 6 8 10 12 14 16 18 20).
	p2 barSize: size.
	p2 color: Color blue.
	p2 barOffset: size * 0.
	
	p3 := RSBarPlot new x: x y: #(3 6 9 12 15 18 21 24 27 30).
	p3 barSize: size.
	p3 color: Color orange.
	p3 barOffset: size * 1.
	
	p4 := RSBarPlot new x: x y: #(4 8 12 16 20 24 28 32 36 40).
	p4 barSize: size.
	p4 color: Color purple.
	p4 barOffset: size * 2.
	
	
	c add: p.
	c add: p2.
	c add: p3.
	c add: p4.


	c build.
	"p bars @ RSPopup."

	^ c canvas
]

{ #category : #'as yet unclassified' }
RoassalExperiment >> barChartExample2 [

	<bookExample>
	| c p p2 p3 p4 x y size |
	x := 1 to: 10.
	y := (x raisedTo: 2) - 2.


	c := RSChart new.
	c extent: 200 @ 200.
	c addDecoration: (RSChartTitleDecoration new
			 title: 'hello';
			 fontSize: 20).
	c ylabel: 'Scores'.
	c xlabel: 'data'.
	c addDecoration:
		(RSHorizontalTick new fromNames: #( 1 2 3 4 5 6 7 8 9 10 )).
	c addDecoration: RSVerticalTick new integer.

	size := 4.

	p := RSBarPlot new x: x y: #( 1 2 3 4 5 6 7 8 9 10 ).
	p barSize: size.
	p color: Color red.
	p gapRatio: 0.5.
	p barOffset: size * -1.

	p2 := RSBarPlot new x: x y: #( 2 4 6 8 10 12 14 16 18 20 ).
	p2 barSize: size.
	p2 color: Color blue.
	p2 barOffset: size * 0.

	p3 := RSBarPlot new x: x y: #( 3 6 9 12 15 18 21 24 27 30 ).
	p3 barSize: size.
	p3 color: Color orange.
	p3 barOffset: size * 1.

	p4 := RSBarPlot new x: x y: #( 4 8 12 16 20 24 28 32 36 40 ).
	p4 barSize: size.
	p4 color: Color purple.
	p4 barOffset: size * 2.


	c add: p.
	c add: p2.
	c add: p3.
	c add: p4.


	c build.
	"p bars @ RSPopup."

	^ c canvas
]

{ #category : #'as yet unclassified' }
RoassalExperiment >> barChartWithLegendExample [

	<bookExample>
	| c p p2 p3 p4 lb x y size |
	x := 1 to: 10.
	y := (x raisedTo: 2) - 2.


	c := RSChart new.
	c extent: 300 @ 200.
	c addDecoration: (RSChartTitleDecoration new
			 title: 'sample bar chart';
			 fontSize: 20).

	c addDecoration:
		(RSHorizontalTick new fromNames: #( 1 2 3 4 5 6 7 8 9 10 )).
	c addDecoration: RSVerticalTick new integer.
	"add it after decoration so their space is computed correctly"
	c ylabel: 'Scores'.
	c xlabel: 'data'.

	size := 4.

	p := RSBarPlot new x: x y: #( 1 2 3 4 5 6 7 8 9 10 ).
	p barSize: size.
	p color: Color red.
	p gapRatio: 0.5.
	p barOffset: size * -1.

	p2 := RSBarPlot new x: x y: #( 2 4 6 8 10 12 14 16 18 20 ).
	p2 barSize: size.
	p2 color: Color blue.
	p2 barOffset: size * 0.

	p3 := RSBarPlot new x: x y: #( 3 6 9 12 15 18 21 24 27 30 ).
	p3 barSize: size.
	p3 color: Color orange.
	p3 barOffset: size * 1.

	p4 := RSBarPlot new x: x y: #( 4 8 12 16 20 24 28 32 36 40 ).
	p4 barSize: size.
	p4 color: Color purple.
	p4 barOffset: size * 2.

	c add: p.
	c add: p2.
	c add: p3.
	c add: p4.

	c build.

	lb := RSLegend new.
	lb layout vertical.
	lb title: 'legend'.
	
	#( p1 p2 p3 p4 ) doWithIndex: [ :lbl :index |
		lb text: lbl withBoxColor: (c plots at: index) computeColor ].
	lb container: c canvas.
	lb location right middle offset: 20.
	lb build.


	"p bars @ RSPopup."

	^ c canvas
]

{ #category : #'as yet unclassified' }
RoassalExperiment >> lineChartExample1 [
	<bookExample>
| c p p2 p3 p4 x y size |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	
	
	c := RSChart  new.
	c extent: 200@200.
	c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 10).
	c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 10).
	
	size := 4.
	
	p := RSLinePlot  new x: x y: #(1 2 3 4 5 6 7 8 9 10).
	p color: Color red.
	
	p2 := RSLinePlot new x: x y: #(2 4 6 8 10 12 14 16 18 20).
	p2 color: Color blue.

	
	p3 := RSLinePlot new x: x y: #(3 6 9 12 15 18 21 24 27 30).
	p3 color: Color orange.
	
	p4 := RSLinePlot new x: x y: #(4 8 12 16 20 24 28 32 36 40).
	p4 color: Color purple.
	
	
	c add: p.
	c add: p2.
	c add: p3.
	c add: p4.


	c build.
	"p bars @ RSPopup."

	^ c canvas
]

{ #category : #'as yet unclassified' }
RoassalExperiment >> stackedBar [

	<bookExample>
	| c menMeans womenMeans lb |
	c := RSChart new.
	c extent: 300 @ 200.
	menMeans := #( 20 35 30 35 27 ).
	womenMeans := #( 25 32 34 20 25 ).
	c barHeights: menMeans.
	(c barHeights: womenMeans) bottom: menMeans.
	c addDecoration:
		(RSHorizontalTick new fromNames: #( Day1 Day2 Day3 Day4 Day5 )).
	c addDecoration: RSVerticalTick new integer.
	c ylabel: 'Scores'.
	c title: 'Amortization chart'.
	c build.
	lb := RSLegend new.
	lb layout horizontal.
	#( Men Women ) doWithIndex: [ :lbl :index |
		lb text: lbl withBoxColor: (c plots at: index) computeColor ].
	lb container: c canvas.
	lb build.
	^ c canvas
]
