initialization
sendMOSMS

	| op myCalledSCCPAddress myCallingSCCPAddress |
	
	myCallingSCCPAddress := (SCCPAddress createWith: SCCPAddress ssnMSC)
		  routedOnSSN: false;
		  gtiFromAddr: (SCCPGlobalTitleTranslation new
				   nature: SCCPGlobalTitle naiInternationalNumber;
				   plan: SCCPGlobalTitle npISDN;
				   addr: mapProxy mscNumber;
				   translation: 0;
				   yourself);
		  yourself.
	myCalledSCCPAddress := (SCCPAddress createWith: SCCPAddress ssnMSC)
		  routedOnSSN: false;
		  gtiFromAddr: (SCCPGlobalTitleTranslation new
				   nature: SCCPGlobalTitle naiInternationalNumber;
				   plan: SCCPGlobalTitle npISDN;
				   addr: self serviceCentreAddress;
				   translation: 0;
				   yourself);
		  yourself.		
	op := MAPProxyMOForwardSMOperation new.
	op
		dialogue: mapProxy newDialogue;
		callingSCCPAddress: myCallingSCCPAddress;
		calledSCCPAddress: myCalledSCCPAddress;
		imsi: imsi;
		serviceCentreAddress: self serviceCentreAddress;
		mscNumber: mapProxy mscNumber;
		onFailure: [ "self returnUpdateLocationFailureFor: aRequest on: aDelegate"
			 ];
		onSuccess: [ :result | "self
				returnUpdateLocationResultFor: aRequest
				with: op
				on: aDelegate
				result: result"
			 ];
		start