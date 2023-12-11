initialization
sendUpdateLocation

	| gt op |
	gt := mapProxy gtForIMSI: self imsi.
	op := MAPProxyUpdateLocationOperation new.
	op
		dialogue: mapProxy newDialogue;
		callingSCCPAddress: (mapProxy callingSCCPAddress: gt callingSSN);
		calledSCCPAddress: (mapProxy calledSCCPAddress: (gt prepare: imsi));
		imsi: imsi;
		mscNumber: mapProxy mscNumber;
		vlrNumber: mapProxy vlrNumber;
		onFailure: [ "self returnUpdateLocationFailureFor: aRequest on: aDelegate"
			 ];
		onSuccess: [ :result | "self
				returnUpdateLocationResultFor: aRequest
				with: op
				on: aDelegate
				result: result"
			 ];
		start