# KyivstarTV Demo
# Hello! 

This test briefly touches on key aspects of working in our `iOS` team, so try your best ;) 

You need to do this layout:

<img src="https://i.imgur.com/G4DAPSk.png" width="550" height="400">
https://www.figma.com/file/9RIx2wI8xY1edWmch1K9x1/Untitled?node-id=0%3A1&t=iB6LMzByfLlwsM0v-1

It contains content groups with assets and asset page with some simple logic. 
You can do only required screen, or required and optional screens.
You must use:
1. MVVM
2. Combine for binding

Any other technics and mechanics - on your choice.

### API Details
Network setup is attached inside postman collection. Feel free to import it.

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

Please, no storyboards, xib files, localizations, CoreData. I recommend using pods - Alamofire for networking and Kingfisher for image load and cache.

Additional flow, not required, but will be a plus:
1. User can tap on any asset and open asset details page

We will accept solutions in pull requests to this repository.
The best solution will be pushed into main repository - so everyone can know something new for himself.

GL HF.

p.s. If you have any questions(maybe some endpoints stoped working, or flow is not clear), feel free to create issues inside this repository, we'll try to react quickly. 
