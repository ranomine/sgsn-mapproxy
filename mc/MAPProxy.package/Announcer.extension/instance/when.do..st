*MAPProxy
when: anAnnouncementClass do: aValuable
	"Subscribe aSubscriber to announcements of anAnnouncementClass class. 
	 When the announcement is raised, aValuable is executed."

	^ registry add: (AnnouncementSubscription new
			   announcer: self;
			   announcementClass: anAnnouncementClass;
			   action: aValuable;
			   yourself)
