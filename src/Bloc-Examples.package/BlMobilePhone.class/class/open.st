instance creation
open
	<script: 'self open'>
	BlSpace new
		title: 'iOS Simulator';
		extent: (self pxBodyWidth @ self pxBodyHeight) + (10@10);
		rootDo: [ :r | r 
			layout:(BlLinearLayout vertical );
			addChild: self new ];
		show