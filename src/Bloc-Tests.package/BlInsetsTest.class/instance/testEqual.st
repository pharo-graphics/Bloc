tests
testEqual
	self
		assert:
			(BlInsets
				top: 1
				right: 4
				bottom: 3
				left: 2)
				=
					(BlInsets
						top: 1
						left: 2
						bottom: 3
						right: 4)