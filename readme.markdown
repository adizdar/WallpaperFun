#WallpaperFun Sample Documentation
=================================

###Project Structure

* /WallpaperFun
    + /Classes
        - /Application      # App delegate and related files
        - /Controllers      # Base view controllers
        - /Models           # Models, Core Data schema etc
        - /ViewComponents   # Custom View Components
        - /ServiceLayer     # Layer for networking
        - /Library          # Anything that falls outside of the MVC pattern
        - /Support          # Categories and helpers
    + /Other sources        # Prefix headers, main.m
    + /Supporting files     # Info.plist
    + /Resources                # Images, videos, .strings files
    + /StoryBords               # Story bords of the project
    + /DataSources              # DataSources for UITableView, CollectioView ...
    + /Vendor                   # 3rd party dependencies not managed by CocoaPods


###Vendor

For managing dependencies CocoaPods are used, thats way *.xcworkspace project file needs to be loaded into XCode.


