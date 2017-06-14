pulse
render

	self hostSpace ifNotNil: [ :aHostSpace |
		aHostSpace render: self ]