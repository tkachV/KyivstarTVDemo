# VidmindDemo
# Hello! 

This test briefly touches on key aspects of working in our `iOS` team, so try your best ;) 

You need to do this layout:

<img src="https://i.imgur.com/gErK5ao.png" width="550" height="400">
https://www.figma.com/file/1IqZeO82xgkd3TpIMDT863/iOS-Test-Task?node-id=0%3A1

It contains player, content groups with assets inside and some simple logic. 

### Let's begin.

To load list of content groups please use [this endpoint](https://next.json-generator.com/api/json/get/Ey9bcQTEq).
It returns you an array of content groups in this format:

```json
[
  {
    "id": "60643c0673cd2113bb65de36",
    "name": "anim dolore"
  }
  ..
]
```

Nice! Now you need to load some assets (movies, series, live channels) inside your already loaded content groups. 
Let's do it using this endpoint - https://next.json-generator.com/api/json/get/VkHeTQ6Vq?groupId=60643c0673cd2113bb65de36. You have to pass content group id as GET parameter `?groupId=...`
Which will return you array of some awesome assets, like below:

```json
[
  {
    "id": "60645015ddc3cd2f2b687f0c",
    "image": "https://source.unsplash.com/random/400x600",
    "type": "LIVECHANNEL",
    "url": "https://multiplatform-f.aka.../master.m3u8",
    "plot": "Voluptate ..",
    "canRemove": true,
    "removeMessage": "labore nisi minim magna",
    "progress": 0
  }
  ..
]
```


Allright, that's all for network. Not difficult, yep? ;) 

Now let's go ahead to our UI and I'll show you the main flow. Please read carefully:

1. User opens application.
2. Network calls start to load information. You can make network calls `sync` or `async` - depends on you. 
3. Next - show an empty player with ui buttons and all other layout according to design. 
4. Get the first element of the first content group and start to play it using your `AVPlayer`
5. Update information (title, now playing, plot) under player according to selected asset, which is currently playing.
6. User can select any asset from content group and play it via `url`
7. User can see progress bar under asset image, if `progress > 0`
8. User can tap `Delete` button - which will remove asset from content group if `canRemove` flag of asset is set to true. Deletion will affect after `UIAlertAction` will be show with confirmation and text from `removeMessage` field.
9. If content group after deletion remains empty - please remove it also.
10. User can rotate phone and watch asset in fullscreen mode. Also user can use fullscreen button and play pause buttons.

That's all flow. Please, no storyboards, xib files, localizations, CoreData. I recommend using pods - Alamofire for networking and Kingfisher for image load and cache.

Additional flow, not required, but will be a plus:
1. When video reaches end, start playing next video from current content group
2. Content groups must have infinite scrolling, some way of pagination (load endpoint of content group one more time with params `https://next.json-generator.com/api/json/get/VkHeTQ6Vq?groupId=60643c0673cd2113bb65de36&limit=10&offset=10`)


We will accept solutions in pull requests to this repository.
The best solution will be pushed into main repository - so everyone can know something new for himself.
Good luck and have fun. 

p.s. If you have any questions(maybe some endpoints stoped working, or video is not playing - but it has to), feel free to create issues inside this repository, we'll try to react quickly. 
