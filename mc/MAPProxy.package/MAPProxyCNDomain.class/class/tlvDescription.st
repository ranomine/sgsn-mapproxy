as yet unclassified
tlvDescription
	^TLVDescription new
		instVarName: #domain;
		parseClass: self;
		useDelegatedWrite;
		beTLV;
		beForceTagged;
		tag: 16r28;
		yourself