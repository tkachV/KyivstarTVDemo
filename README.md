# KyivstarTV Demo
# Hello! 

This test briefly touches on key aspects of working in our `iOS` team, so try your best ;) 

You need to do this layout:

<img src="https://i.imgur.com/G4DAPSk.png" width="650" height="450">
https://www.figma.com/file/9RIx2wI8xY1edWmch1K9x1/Untitled?node-id=0%3A1&t=iB6LMzByfLlwsM0v-1

It contains content groups with assets and asset page with some simple logic. 
You can do only required screen, or required and optional screens.
You must use:

0. UIKit
1. MVVM
2. Combine for binding
3. Diffable Data Source and Compositional Layout
4. ios <= 13.4

Any other technics and mechanics - on your choice.

### API Details
Network setup is attached inside postman collection. Feel free to import it.

Bearer Token: u0xj6pw0fdf7m2l1dvcic7uolk45e79itgin54l8

All necessary requests and headers with tokens are stored there. 

When loading list of content groups please pay attention on content group type. 

`
MOVIE, SERIES, LIVECHANNEL, EPG
`

Depending on type - build layout (more details in figma)

Basic flow:

1. User opens application.
2. Network calls start to load information. You can make network calls `sync` or `async` - depends on you. Also you can create skeletons if you want.
3. When some of the data is loaded - user starts to see it on screen.
4. User can see progress bar under asset image, if `progress > 0`
5. User can tap `Del` button - which will remove content group from screen if `canBeDeleted` flag of contentGroup is set to true

Additional flow, not required, but will be a plus:
1. User can tap on any asset and open asset details page
2. Make network call to load asset details
3. Pay attention on UI in figma, how it have to work

Please, no storyboards, xib files, localizations, CoreData. 
I recommend using SPM's - Alamofire for networking, Kingfisher for image load and cache, SnapKit for AutoLayout.


We will accept solutions in pull requests to this repository.
The best solution will be pushed into main repository - so everyone can know something new for himself.

GL HF.

p.s. If you have any questions(maybe some endpoints stoped working, or flow is not clear), feel free to create issues inside this repository, we'll try to react quickly. 
