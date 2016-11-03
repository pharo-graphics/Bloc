bind/unbind
unbind
	toListener ifNotNil: [ to removeChangeListener: toListener ].
	fromListener ifNotNil: [ from removeChangeListener: fromListener ].
	to := from := toListener := fromListener := nil