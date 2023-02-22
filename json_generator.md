This is system file with json instructions to generate json's at online source - http://json-generator.com/ .
Ignore this file.

Content Groups
JG.repeat(10, 15, {
  id: JG.objectId(),
  name: JG.street(),
  canBeDeleted: JG.bool(),
  type: JG.random(["MOVIE"], ["SERIES"], ["LIVECHANNEL"], ["EPG"]),
  assets: JG.repeat(15, 25, {
    id: JG.objectId(),
    image: `https://picsum.photos/id/${JG.integer(1, 999)}/400/600`,
    name: JG.loremIpsum({units: 'words', count: JG.integer(1, 3)}),
    purchased: JG.bool(),
    progress(purchased) {
        if(this.purchased) {
            return Math.floor(Math.random() * (100 - 1 + 1) + 1);            
        } else {
          return 0;
        }
      },
    company: JG.company(),
    releaseDate: moment(JG.date(new Date(1988, 0, 1), new Date(1995, 0, 1))).format('YYYY-MM-DD'),
    updatedAt: JG.date(new Date(2010, 0, 1), new Date(2015, 0, 1)),
  })
});

Promotions
{
  id: JG.objectId(),
  name: "Promotions",
  promotions: JG.repeat(15, 25, {
    id: JG.objectId(),
    image: `https://picsum.photos/id/${JG.integer(1, 999)}/900/500`,
    name: JG.loremIpsum({units: 'words', count: JG.integer(1, 3)}),
    company: JG.company(),
    releaseDate: moment(JG.date(new Date(1988, 0, 1), new Date(1995, 0, 1))).format('YYYY-MM-DD'),
    updatedAt: JG.date(new Date(2010, 0, 1), new Date(2015, 0, 1)),
  })
}


Categories
{
  categories: JG.repeat(15, 25, {
    id: JG.objectId(),
    image: `https://picsum.photos/id/${JG.integer(1, 999)}/400/400`,
    name: JG.loremIpsum({units: 'words', count: JG.integer(1, 3)})
  })
}

assetDetails
{
  id: JG.objectId(),
    image: `https://picsum.photos/id/${JG.integer(1, 999)}/900/600`,
    name: JG.loremIpsum({units: 'sentenses', count: JG.integer(3, 6)}),
    purchased: JG.bool(),
    progress(purchased) {
        if(this.purchased) {
            return Math.floor(Math.random() * (100 - 1 + 1) + 1);            
        } else {
          return 0;
        }
      },
    company: JG.company(),
    releaseDate: moment(JG.date(new Date(1988, 0, 1), new Date(1995, 0, 1))).format('YYYY-MM-DD'),
    updatedAt: JG.date(new Date(2010, 0, 1), new Date(2015, 0, 1)),
      description: JG.loremIpsum({units: 'sentences', count: JG.integer(3, 6)}),
        similar: JG.repeat(15, 25, {
    id: JG.objectId(),
    image: `https://picsum.photos/id/${JG.integer(1, 999)}/400/600`,
    name: JG.loremIpsum({units: 'words', count: JG.integer(1, 3)}),
    purchased: JG.bool(),
    progress(purchased) {
        if(this.purchased) {
            return Math.floor(Math.random() * (100 - 1 + 1) + 1);            
        } else {
          return 0;
        }
      },
    company: JG.company(),
    releaseDate: moment(JG.date(new Date(1988, 0, 1), new Date(1995, 0, 1))).format('YYYY-MM-DD'),
    updatedAt: JG.date(new Date(2010, 0, 1), new Date(2015, 0, 1)),
  })
}
