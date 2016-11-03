shape creation
newImage
	^ (BlBitmap fromFileNamed:'/home/glenn/Images/window-bloc.png')
		geometry:BlEllipse new;
		extent: 200 @ 100;
		border: (BlBorder color: Color gray width: 2);
		yourself