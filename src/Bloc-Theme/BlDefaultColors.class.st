Class {
	#name : #BlDefaultColors,
	#superclass : #SharedPool,
	#classVars : [
		'ActiveColor',
		'BackdropColor',
		'ButtonBackgroundColor',
		'ButtonBorderColor',
		'ButtonHoveredBackgroundColor',
		'ButtonPressedBackgroundColor',
		'ButtonTextColor',
		'DarkBorderColor',
		'DefaultDividerBackgroundColor',
		'DefaultDividerBorderColor',
		'DeselectedListItemBackgroundColor',
		'DisabledButtonBackgroundColor',
		'DisabledButtonBorderColor',
		'DisabledButtonTextColor',
		'DisabledDividerBackgroundColor',
		'DisabledDividerBorderColor',
		'DisabledHeaderTextColor',
		'EditorBorderColor',
		'ErrorBackgroundColor',
		'ErrorBorderColor',
		'ExpandCollapseTriangleBackgroundColor',
		'FailureBackgroundColor',
		'FailureBorderColor',
		'FocusedEditorBorderColor',
		'HeaderBackgroundColor',
		'HeaderTextColor',
		'HoveredButtonBorderColor',
		'HoveredButtonTextColor',
		'HoveredDividerBackgroundColor',
		'HoveredDividerBorderColor',
		'HoveredListItemBackgroundColor',
		'HoveredListItemBorderColor',
		'LightBorderColor',
		'LinkColor',
		'LinkWithErrorColor',
		'NeutralBackgroundColor',
		'NewsBackgroundColor',
		'PaleErrorBackgroundColor',
		'PressedButtonBorderColor',
		'PressedButtonTextColor',
		'PressedDividerBackgroundColor',
		'PressedDividerBorderColor',
		'PressedListItemBackgroundColor',
		'PressedListItemBorderColor',
		'PrimaryBorderColor',
		'SecondaryHeaderBackgroundColor',
		'SelectedListItemBackgroundColor',
		'ShadowColor',
		'SuccessBackgroundColor',
		'SuccessBorderColor',
		'TextHighlightColor',
		'TextMarkupColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlDefaultColors class >> backdropColor [
	^ BackdropColor
]

{ #category : #accessing }
BlDefaultColors class >> darkBorderColor [
	^ DarkBorderColor
]

{ #category : #accessing }
BlDefaultColors class >> darkBorderColor: anObject [
	DarkBorderColor := anObject
]

{ #category : #'button - background' }
BlDefaultColors class >> defaultButtonBackgroundColor [
	^ ButtonBackgroundColor
]

{ #category : #'button - background' }
BlDefaultColors class >> defaultButtonBackgroundColor: anObject [
	ButtonBackgroundColor := anObject
]

{ #category : #'button - border' }
BlDefaultColors class >> defaultButtonBorderColor [
	^ ButtonBorderColor
]

{ #category : #'button - border' }
BlDefaultColors class >> defaultButtonBorderColor: anObject [
	ButtonBorderColor := anObject
]

{ #category : #'button - text' }
BlDefaultColors class >> defaultButtonTextColor [
	^ ButtonTextColor
]

{ #category : #'button - text' }
BlDefaultColors class >> defaultButtonTextColor: anObject [
	ButtonTextColor := anObject
]

{ #category : #divider }
BlDefaultColors class >> defaultDividerBackgroundColor [

	^ DefaultDividerBackgroundColor
]

{ #category : #divider }
BlDefaultColors class >> defaultDividerBackgroundColor: aColor [

	DefaultDividerBackgroundColor := aColor
]

{ #category : #divider }
BlDefaultColors class >> defaultDividerBorderColor [

	^ DefaultDividerBorderColor
]

{ #category : #divider }
BlDefaultColors class >> defaultDividerBorderColor: aColor [

	DefaultDividerBorderColor := aColor
]

{ #category : #'header - background' }
BlDefaultColors class >> defaultHeaderBackgroundColor [
	^ HeaderBackgroundColor
]

{ #category : #'header - text' }
BlDefaultColors class >> defaultHeaderTextColor [
	^ HeaderTextColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> defaultListItemBackgroundColor [
	^ self deselectedListItemColor
]

{ #category : #accessing }
BlDefaultColors class >> defaultShadowColor [
	^ ShadowColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> deselectedListItemColor [
	^ DeselectedListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> deselectedtListItemColor: aColor [
	DeselectedListItemBackgroundColor := aColor
]

{ #category : #'button - background' }
BlDefaultColors class >> disabledButtonBackgroundColor [
	^ DisabledButtonBackgroundColor
]

{ #category : #'button - background' }
BlDefaultColors class >> disabledButtonBackgroundColor: anObject [
	DisabledButtonBackgroundColor := anObject
]

{ #category : #'button - border' }
BlDefaultColors class >> disabledButtonBorderColor [
	^ DisabledButtonBorderColor
]

{ #category : #'button - border' }
BlDefaultColors class >> disabledButtonBorderColor: anObject [
	DisabledButtonBorderColor := anObject
]

{ #category : #'button - text' }
BlDefaultColors class >> disabledButtonTextColor [
	^ DisabledButtonTextColor
]

{ #category : #'button - text' }
BlDefaultColors class >> disabledButtonTextColor: anObject [
	DisabledButtonTextColor := anObject
]

{ #category : #divider }
BlDefaultColors class >> disabledDividerBackgroundColor [

	^ DisabledDividerBackgroundColor
]

{ #category : #divider }
BlDefaultColors class >> disabledDividerBackgroundColor: aColor [

	DisabledDividerBackgroundColor := aColor
]

{ #category : #divider }
BlDefaultColors class >> disabledDividerBorderColor [

	^ DisabledDividerBorderColor
]

{ #category : #divider }
BlDefaultColors class >> disabledDividerBorderColor: aColor [

	DisabledDividerBorderColor := aColor
]

{ #category : #'header - text' }
BlDefaultColors class >> disabledHeaderTextColor [
	^ DisabledHeaderTextColor
]

{ #category : #accessing }
BlDefaultColors class >> distinctTenLightColors [
	"This is a list of 10 light colors that can be distinguished b
	the typical human eye even when seen together in the same picture.
	They complement the distinctTenStrongColors.
	They are described in the Show Me the Numbers book by Stephen Few"

	^ OrderedCollection new
		"red"
		add: (Color 
					h: Color red hue
					s: 0.3
					v: Color red brightness);
		"blue"
		add: (Color 
					h: Color blue hue
					s: 0.3
					v: Color blue brightness);
		"orange"
		add: (Color 
					h: Color orange hue
					s: 0.3
					v: Color orange brightness);
		"cyan"
		add: (Color 
					h: Color cyan hue
					s: 0.3 
					v: Color cyan brightness );
		"green"
		add: (Color 
					h: Color lightGreen hue
					s: 0.1
					v: 0.7);
		"pink"
		add: (Color 
					h: Color pink hue
					s: 0.1
					v: Color pink brightness);
		"brown"
		add: (Color 
					h: Color brown hue
					s: 0.2
					v: 1 );
		"purple"
		add: (Color 
					h: Color purple hue
					s: 0.2
					v: Color purple brightness );
		"yellow"
		add: (Color 
					h: Color yellow hue
					s: 0.3
					v: Color yellow brightness);
		"gray"
		add: (Color veryLightGray);
		yourself;


		yourself
]

{ #category : #accessing }
BlDefaultColors class >> distinctTenStrongColors [
	"This is a list of 10 light colors that can be distinguished b
	the typical human eye even when seen together in the same picture.
	They complement the distinctTenLightColors.
	They are described in the Show Me the Numbers book by Stephen Few"

	^ (OrderedCollection new)
			add: Color red;
			add: Color blue;
			add: Color orange;
			add: Color cyan;
			add: Color green;
			add: Color pink;
			add: Color brown;
			add: Color purple;
			add: Color yellow;
			add: Color gray;
			yourself
]

{ #category : #'editor - border' }
BlDefaultColors class >> editorBorderColor [
	^ EditorBorderColor
]

{ #category : #'editor - border' }
BlDefaultColors class >> editorBorderColor: anObject [
	EditorBorderColor := anObject
]

{ #category : #'status - background' }
BlDefaultColors class >> errorBackgroundColor [
	^ ErrorBackgroundColor
]

{ #category : #'status - background' }
BlDefaultColors class >> errorBackgroundColor: aColor [
	ErrorBackgroundColor := aColor
]

{ #category : #'status - border' }
BlDefaultColors class >> errorBorderColor [
	^ ErrorBorderColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> expandCollapseTriangleBackgroundColor [
	^ ExpandCollapseTriangleBackgroundColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> expandCollapseTriangleBackgroundColor: aColor [
	ExpandCollapseTriangleBackgroundColor := aColor
]

{ #category : #'status - background' }
BlDefaultColors class >> failureBackgroundColor [
	^ FailureBackgroundColor
]

{ #category : #'status - background' }
BlDefaultColors class >> failureBackgroundColor: aColor [
	FailureBackgroundColor := aColor
]

{ #category : #'status - border' }
BlDefaultColors class >> failureBorderColor [
	^ FailureBorderColor
]

{ #category : #'editor - border' }
BlDefaultColors class >> focusedEditorBorderColor [
	^ FocusedEditorBorderColor
]

{ #category : #'editor - border' }
BlDefaultColors class >> focusedEditorBorderColor: anObject [
	FocusedEditorBorderColor := anObject
]

{ #category : #'list and tree items - border' }
BlDefaultColors class >> focusedListItemBorder [
	^ self primaryBorderColor
]

{ #category : #'button - background' }
BlDefaultColors class >> hoveredButtonBackgroundColor [

	^ ButtonHoveredBackgroundColor
]

{ #category : #'button - border' }
BlDefaultColors class >> hoveredButtonBorderColor [
	^ HoveredButtonBorderColor
]

{ #category : #'button - border' }
BlDefaultColors class >> hoveredButtonBorderColor: anObject [
	HoveredButtonBorderColor := anObject
]

{ #category : #'button - text' }
BlDefaultColors class >> hoveredButtonTextColor [
	^ HoveredButtonTextColor
]

{ #category : #'button - text' }
BlDefaultColors class >> hoveredButtonTextColor: anObject [
	HoveredButtonTextColor := anObject
]

{ #category : #divider }
BlDefaultColors class >> hoveredDividerBackgroundColor [

	^ HoveredDividerBackgroundColor
]

{ #category : #divider }
BlDefaultColors class >> hoveredDividerBackgroundColor: aColor [

	HoveredDividerBackgroundColor := aColor
]

{ #category : #divider }
BlDefaultColors class >> hoveredDividerBorderColor [

	^ HoveredDividerBorderColor
]

{ #category : #divider }
BlDefaultColors class >> hoveredDividerBorderColor: aColor [

	HoveredDividerBorderColor := aColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> hoveredListItemBackgroundColor [
	^ HoveredListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> hoveredListItemBackgroundColor: aColor [
	HoveredListItemBackgroundColor := aColor
]

{ #category : #'list and tree items - border' }
BlDefaultColors class >> hoveredListItemBorderColor [

	^ HoveredListItemBorderColor
]

{ #category : #initialization }
BlDefaultColors class >> initialize [
	LightBorderColor := Color fromHexString: #d9d9d9.
	DarkBorderColor := Color darkGray.
	PrimaryBorderColor := Color fromHexString: #'45abfe'.
	ActiveColor := Color fromHexString: #'096dd9'.

	"buttons - border"
	ButtonBorderColor := LightBorderColor.
	HoveredButtonBorderColor := PrimaryBorderColor.
	PressedButtonBorderColor := ActiveColor.
	DisabledButtonBorderColor := LightBorderColor.

	"status - border"
	SuccessBorderColor := Color fromHexString: #'389e0d' "green-7".
	ErrorBorderColor := Color fromHexString: #'cf1322' "red-7".
	FailureBorderColor := Color fromHexString: #'d48806' "gold-7".

	"buttons - background"
	ButtonBackgroundColor := Color white.
	DisabledButtonBackgroundColor := Color fromHexString: #f5f5f5 "grey-3".
	ButtonHoveredBackgroundColor := Color white darker.
	ButtonPressedBackgroundColor := ButtonHoveredBackgroundColor darker.

	"status - background"
	PaleErrorBackgroundColor := Color fromHexString: #'#ffccc7' "red-2".
	ErrorBackgroundColor := Color fromHexString: #ff7875 "red-4".
	SuccessBackgroundColor := Color fromHexString: #'95de64' "green-4".
	FailureBackgroundColor := Color fromHexString: #ffd666 "gold-4".
	NeutralBackgroundColor := Color fromHexString: #'f0f0f0' "gray-4".
	NewsBackgroundColor := Color fromHexString: #'fff1b8' "gold-2".
	
	"buttons - text"
	ButtonTextColor := Color black alpha: 0.65.
	HoveredButtonTextColor := PrimaryBorderColor.
	PressedButtonTextColor := ActiveColor.
	DisabledButtonTextColor := Color black alpha: 0.25.

	"background"
	BackdropColor := Color r: 240 g: 240 b: 240 range: 255.
	ShadowColor := Color r: 200 g: 200 b: 200 range: 255.
	
	"header - background"
	HeaderBackgroundColor := Color fromHexString: #'d9d9d9'. "grey-5"
	SecondaryHeaderBackgroundColor := Color fromHexString: #'e8e8e8'. "grey-6"
	
	"header - text"
	HeaderTextColor := Color black alpha: 0.85.
	DisabledHeaderTextColor := Color black alpha: 0.25.
	
	"highlighting - text"
	TextHighlightColor := Color fromHexString: #ffd666.
	TextMarkupColor := Color black alpha: 0.6.
	
	"list and tree items"
	DeselectedListItemBackgroundColor := Color transparent.
	HoveredListItemBackgroundColor := Color veryVeryLightGray alpha: 0.1.
	HoveredListItemBorderColor := Color gray alpha: 0.3.
	SelectedListItemBackgroundColor := Color gray darker.
	PressedListItemBackgroundColor := Color gray alpha: 0.2. 
	PressedListItemBorderColor := Color gray alpha: 0.4. 
	ExpandCollapseTriangleBackgroundColor := Color fromHexString: #'d9d9d9'. "grey-5"

	"editors"
	EditorBorderColor := LightBorderColor.
	FocusedEditorBorderColor := PrimaryBorderColor.
	
	" dividers "
	DefaultDividerBorderColor := Color veryLightGray muchLighter.
	DefaultDividerBackgroundColor := Color veryLightGray muchLighter.
	DisabledDividerBackgroundColor := Color transparent.
	DisabledDividerBorderColor := Color transparent.
	PressedDividerBorderColor := Color transparent.
	PressedDividerBackgroundColor := Color lightGray.
	HoveredDividerBorderColor := Color transparent.
	HoveredDividerBackgroundColor := Color veryLightGray.
	
	"others"
	LinkColor := Color fromHexString: #'096dd9'.
	LinkWithErrorColor := Color fromHexString: #cf1322.
]

{ #category : #testing }
BlDefaultColors class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
BlDefaultColors class >> lightBorderColor [
	^ LightBorderColor
]

{ #category : #accessing }
BlDefaultColors class >> lightBorderColor: anObject [
	LightBorderColor := anObject
]

{ #category : #links }
BlDefaultColors class >> linkColor [
	^ LinkColor
]

{ #category : #links }
BlDefaultColors class >> linkWithErrorColor [
	^ LinkWithErrorColor
]

{ #category : #'status - background' }
BlDefaultColors class >> neutralBackgroundColor [
	^ NeutralBackgroundColor
]

{ #category : #accessing }
BlDefaultColors class >> newsBackgroundColor [
	^ NewsBackgroundColor
]

{ #category : #'status - background' }
BlDefaultColors class >> paleErrorBackgroundColor [
	^ PaleErrorBackgroundColor
]

{ #category : #'button - background' }
BlDefaultColors class >> pressedButtonBackgroundColor [

	^ ButtonPressedBackgroundColor
]

{ #category : #'button - border' }
BlDefaultColors class >> pressedButtonBorderColor [
	^ PressedButtonBorderColor
]

{ #category : #'button - border' }
BlDefaultColors class >> pressedButtonBorderColor: anObject [
	PressedButtonBorderColor := anObject
]

{ #category : #'button - text' }
BlDefaultColors class >> pressedButtonTextColor [
	^ PressedButtonTextColor
]

{ #category : #'button - text' }
BlDefaultColors class >> pressedButtonTextColor: anObject [
	PressedButtonTextColor := anObject
]

{ #category : #divider }
BlDefaultColors class >> pressedDividerBackgroundColor [

	^ PressedDividerBackgroundColor
]

{ #category : #divider }
BlDefaultColors class >> pressedDividerBackgroundColor: aColor [

	PressedDividerBackgroundColor := aColor
]

{ #category : #divider }
BlDefaultColors class >> pressedDividerBorderColor [

	^ PressedDividerBorderColor
]

{ #category : #divider }
BlDefaultColors class >> pressedDividerBorderColor: aColor [

	PressedDividerBorderColor := aColor
]

{ #category : #'list and tree items - border' }
BlDefaultColors class >> pressedListItemBorderColor [

	^ PressedListItemBorderColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> pressedListItemColor [
	^ PressedListItemBackgroundColor 
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> pressedListItemColor: aColor [
	PressedListItemBackgroundColor := aColor
]

{ #category : #accessing }
BlDefaultColors class >> primaryBorderColor [
	^ PrimaryBorderColor
]

{ #category : #accessing }
BlDefaultColors class >> primaryBorderColor: anObject [
	PrimaryBorderColor := anObject
]

{ #category : #'header - background' }
BlDefaultColors class >> secondaryHeaderBackgroundColor [
	^ SecondaryHeaderBackgroundColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> selectedListItemColor [
	^ SelectedListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
BlDefaultColors class >> selectedListItemColor: aColor [
	SelectedListItemBackgroundColor := aColor
]

{ #category : #accessing }
BlDefaultColors class >> shadowColor [
	^ ShadowColor
]

{ #category : #'status - background' }
BlDefaultColors class >> successBackgroundColor [
	^ SuccessBackgroundColor
]

{ #category : #'status - background' }
BlDefaultColors class >> successBackgroundColor: aColor [
	SuccessBackgroundColor := aColor
]

{ #category : #'status - border' }
BlDefaultColors class >> successBorderColor [
	^ SuccessBorderColor
]

{ #category : #'button - border' }
BlDefaultColors class >> textHighlightColor [
	^ TextHighlightColor
]

{ #category : #'button - border' }
BlDefaultColors class >> textHighlightColor: anObject [
	TextHighlightColor := anObject
]

{ #category : #'header - text' }
BlDefaultColors class >> textMarkupColor [
	^ TextMarkupColor
]
