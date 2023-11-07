Class {
	#name : #RdvBlocExperimentDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #accessing }
RdvBlocExperimentDemo >> animatedIconExample [
<gtExample>

|icon elt|

icon := BrGlamorousVectorIcons transcript asElement.
icon constraintsDo: [ :c | c accountTransformation ].

elt := BlElement new
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
    
^elt
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> effectComposite [

	<bookExample>
	
	| compositeEffect|
	
	compositeEffect := BlCompositeEffect effects: {
		BlGaussianShadowEffect color: Color red width: 3 offset: 7 @ 11.
		BlGaussianShadowEffect color: Color green width: 7 offset: -5 @ 7.
		BlGaussianShadowEffect color: Color blue width: 11 offset: 7 @ -5 }.
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
			effect: compositeEffect
		
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> effectGaussianShadow [

	<bookExample>
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
			effect: (BlGaussianShadowEffect color: Color yellow offset: 10@20 width: 5)
		
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> effectSimpleShadow [

	<bookExample>
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
			effect: (BlSimpleShadowEffect color: Color yellow offset: 10@20)
		
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> effectSimpleShadow2 [

	<bookExample>
	^ BlElement new
		  size: 200 @ 100;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color red alpha: 0.2);
		  border: (BlBorder paint: Color yellow width: 1);
		  "layout: BlLinearLayout horizontal alignCenter;""constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];"
		  outskirts: BlOutskirts centered;
		  effect:
			  (BlSimpleShadowEffect color: Color orange offset: -10 @ -20)
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> example1 [

	<bookExample>
	^ BlElement new
		  size: 200 @ 100;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color gray alpha: 0.2);
		  border: (BlBorder paint: Color red width: 1);
		  "layout: BlLinearLayout horizontal alignCenter;""constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];"
		  outskirts: BlOutskirts centered
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> example2 [

	<bookExample>
	^ BlElement new
		  size: 22 @ 14;
		  layout: BlFrameLayout new;
		background: Color purple;
		  padding: (BlInsets all: 3);
		  border: (BlBorder builder
				   width: 1;
				   build);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 8)
]

{ #category : #'accessing - demo' }
RdvBlocExperimentDemo >> exampleWithEvent [

	<bookExample>
	| element |
	element := BlDevElement new
		           size: 200 @ 200;
		           geometry: (BlPolygon vertices: {
						            (100 @ 50).
						            (115 @ 90).
						            (150 @ 90).
						            (125 @ 110).
						            (135 @ 150).
						            (100 @ 130).
						            (65 @ 150).
						            (75 @ 110).
						            (50 @ 90).
						            (85 @ 90) });
		           background: (Color pink alpha: 0.2);
		           border: (BlBorder paint: Color white width: 1);
		           "layout: BlLinearLayout horizontal alignCenter;""constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];"
		           outskirts: BlOutskirts inside.

	element when: BlMouseEnterEvent do: [ :anEvent |
		anEvent consumed: true.
		element background: (Color red alpha: 0.2) ].

	element when: BlMouseLeaveEvent do: [ :anEvent |
		anEvent consumed: true.
		element background: (Color blue alpha: 0.2) ].

	^ element
]

{ #category : #accessing }
RdvBlocExperimentDemo >> helloWorldScene [
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
RdvBlocExperimentDemo >> iconScaleToFitElementExample [
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

{ #category : #accessing }
RdvBlocExperimentDemo >> openSpaceInNewWindowExample [
<bookExample>
	| aSpace |
	
	aSpace := BlSpace new
		addChild: self helloWorldScene;
		extent: 800@600;
		title: 'Hello World'.

	^ aSpace show
]
