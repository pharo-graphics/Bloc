*Bloc-Extensions
gtInspectorOpenInSpace
	<gtInspectorAction>
	^ GLMGenericAction new
		action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
		icon: GLMUIThemeExtraIcons glamorousPlay;
		title: 'Open in Space' translated;
		condition: [ self hasParent not ]