Class {
	#name : #AthensExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Athens'
}

{ #category : #examples }
AthensExperiment >> example1 [
<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 400 @ 400.

	surface drawDuring: [ :canvas |
		| paint font |
		paint := PolymorphSystemSettings pharoLogoForm asAthensPaintOn:
			         canvas.

		canvas setPaint:
			((LinearGradientPaint from: 0 @ 0 to: 400 @ 400) colorRamp: {
					 (0 -> (Color red alpha: 0.8)).
					 (0.166 -> (Color orange alpha: 0.8)).
					 (0.332 -> (Color yellow alpha: 0.8)).
					 (0.5 -> (Color green alpha: 0.8)).
					 (0.664 -> (Color blue alpha: 0.8)).
					 (0.83 -> (Color magenta alpha: 0.8)).
					 (1 -> (Color purple alpha: 0.8)) }).

		canvas drawShape: (0 @ 0 extent: 400 @ 400).
		paint maskOn: canvas.

		font := LogicalFont familyName: 'Source Sans Pro' pointSize: 30.
		canvas setFont: font.
		canvas setPaint:
			((LinearGradientPaint from: 0 @ 0 to: 100 @ 150) colorRamp: {
					 (0 -> (Color white alpha: 0.9)).
					 (1 -> (Color black alpha: 0.9)) }).
		canvas pathTransform
			translateX: 20 Y: 180 + font getPreciseAscent;
			scaleBy: 1.1;
			rotateByDegrees: 25.

		canvas drawString: 'Hello Athens in Pharo'

		"canvas draw." ].

	^surface asForm
]

{ #category : #examples }
AthensExperiment >> example2 [

	<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 400 @ 400.

	surface drawDuring: [ :canvas |
		| stroke squarePath circlePath |
		squarePath := canvas createPath: [ :builder |
			              builder
				              absolute;
				              moveTo: 100 @ 100;
				              lineTo: 100 @ 300;
				              lineTo: 300 @ 300;
				              lineTo: 300 @ 100;
				              close ].
		circlePath := canvas createPath: [ :builder |
			              builder
				              absolute;
				              moveTo: 200 @ 100;
				              cwArcTo: 200 @ 300 angle: 180 degreesToRadians;
				              cwArcTo: 200 @ 100 angle: Float pi ].
		canvas setPaint: Color red.
		canvas drawShape: squarePath.
		stroke := canvas setStrokePaint: Color black.
		stroke
			width: 10;
			joinRound;
			capRound.
		canvas drawShape: squarePath.
		canvas drawShape: circlePath.
		circlePath := canvas createPath: [ :builder |
			              builder
				              relative;
				              moveTo: 175 @ 175;
				              cwArcTo: 50 @ 50 angle: 180 degreesToRadians;
				              cwArcTo: -50 @ -50 angle: Float pi ].
		canvas drawShape: circlePath ].

	^ surface asForm
]

{ #category : #examples }
AthensExperiment >> fillPaint1 [

	<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 200 @ 200.

	surface drawDuring: [ :canvas |
		surface clear: (Color purple alpha: 0.3).
		"linear gradient fill"
		canvas setPaint:
			((LinearGradientPaint from: 0 @ 0 to: 100 @ 100) colorRamp: {
					 (0 -> Color white).
					 (1 -> Color black) }).
		canvas drawShape: (0 @ 0 extent: 100 @ 100).

		"plain color fill"
		canvas setPaint: (Color yellow alpha: 0.9).
		canvas drawShape: (100 @ 0 extent: 200 @ 100).

		"Bitmap fill"
		canvas setPaint:
			(PolymorphSystemSettings pharoLogoForm asAthensPaintOn: canvas).
		canvas paintTransform translateX: 0 Y: 135.
		canvas paintTransform scaleBy: 0.25.
		canvas drawShape: (0 @ 100 extent: 100 @ 200).

		"Radial gradient fill"
		canvas paintTransform loadIdentity.
		canvas setPaint: (RadialGradientPaint new
				 colorRamp: {
						 (0 -> Color white).
						 (1 -> Color black) };
				 center: 150 @ 150;
				 radius: 50;
				 focalPoint: 180 @ 180).
		canvas drawShape: (100 @ 100 extent: 200 @ 200) ].
	^ surface asForm
]

{ #category : #examples }
AthensExperiment >> maskPaint1 [

	<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 400 @ 120.

	surface drawDuring: [ :canvas |
		| paint |
		paint := PolymorphSystemSettings pharoLogoForm asAthensPaintOn:
			         canvas.

		canvas setPaint:
			((LinearGradientPaint from: 0 @ 0 to: 400 @ 120) colorRamp: {
					 (0 -> (Color red alpha: 0.8)).
					 (1 -> (Color yellow alpha: 0.8)) }).


		canvas drawShape: (0 @ 0 extent: 400 @ 120).
		paint maskOn: canvas ].


	^ surface asForm
]

{ #category : #examples }
AthensExperiment >> pathPaint1 [

	<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 100 @ 100.

	surface drawDuring: [ :canvas |
		surface clear: Color white.
		canvas setStrokePaint: Color red.
		canvas paint width: 5.
		canvas drawShape: (canvas createPath: [ :builder |
				 builder
					 absolute;
					 moveTo: 25 @ 25;
					 lineTo: 50 @ 37.5;
					 relative;
					 lineTo: 25 @ -12.5;
					 absolute;
					 cwArcTo: 75 @ 75 angle: 90 degreesToRadians;
					 curveVia: 50 @ 60 and: 50 @ 90 to: 25 @ 75;
					 close ]) ].

	^ surface asForm
]

{ #category : #examples }
AthensExperiment >> strokePaint1 [
<bookExample>

|surface|                                                                        
surface := AthensCairoSurface extent: 200@200.                                   
                                                                                  
surface drawDuring: [ :canvas  |                                              
         surface clear: Color white.                                              
         canvas setStrokePaint:  Color red.                                       
         canvas drawShape: (20@20 extent: 160@160).                          
 ].                                                                               
                                                                                  
^ surface asForm  
]

{ #category : #examples }
AthensExperiment >> strokePaint2 [

	<bookExample>
	| surface |
	surface := AthensCairoSurface extent: 200 @ 200.

	surface drawDuring: [ :canvas |
		surface clear: Color white.
		canvas setStrokePaint: Color red.
		canvas paint dashes: #( 5 15 ) offset: 5. "fill" "gap"
		canvas paint capSquare.
		canvas paint width: 10.
		canvas drawShape: (20 @ 20 extent: 160 @ 160) ].

	^surface asForm
]
