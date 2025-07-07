# iOS-RecipeApp

Summary: Include screen shots or a video of your app highlighting its features. 

https://drive.google.com/file/d/1cKzUM6BWjsTO9DRoxDzrQlk_714Jf4mK/view?usp=share_link

Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

1. Solid data layer: The networking and JSON parsing were important, because if the app can’t load recipes everything else falls apart.
2. Images and caching: Because photos are the largest files, the app grabs a thumbnail only when its row comes into view, then saves it to disk. If you scroll back, it pulls the same image from storage instead of the internet, keeping scrolling smooth and saving data.
3. Clean testable structure: I kept logic in view models and services behind simple protocols, so I could write unit tests without touching the UI. I did this to make sure the core pieces work before I worried about polish.
   
Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about eight hours on this project. The first couple of hours were for setting up the Xcode project, wiring up the models, and making sure I could pull JSON from the endpoint. The next few hours were all about image handling and writing the disk cache. After that, I used about two hours to build the SwiftUI screens and get the error/empty states looking decent. The last hour was for unit tests, video recording, and README touch up.

Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- Basic UI: I used default SwiftUI styles with no custom colors or animations so I could focus more on data loading and caching.
  
Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part is the visual finish. I used SwiftUI’s out of the box styles and didn’t use custom colors. The screens do everything they’re supposed to, but they look plain and default. 
