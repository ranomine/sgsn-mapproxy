initialization
sendMOSMS

	| gt op |
	
	gt := mapProxy gtForIMSI: imsi.
	op := MAPProxyMOForwardSMOperation new.
	op
		dialogue: mapProxy newDialogue;
		callingSCCPAddress: (mapProxy callingSCCPAddress: gt callingSSN);
		calledSCCPAddress: (mapProxy calledSCCPAddress: (gt prepare: imsi));
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