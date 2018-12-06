---
id: md-example
title: Markdown example
sidebar_label: Markdown example
---


## Docusaurus markdown feature

### Document header field

Documents use the following markdown header fields that are enclosed by a line --- on either side:

id: A unique document id. If this field is not present, the document's id will default to its file name (without the extension).

title: The title of your document. If this field is not present, the document's title will default to its id.

hide_title: Whether to hide the title at the top of the doc.

sidebar_label: The text shown in the document sidebar for this document. If this field is not present, the document's sidebar_label will default to its title

### How to refer other file

* [This links to another document: doc1.md](doc1.md)
* [This links to github](http://github.com)


### How to add one image

You can add and image use direct web image link
![Google](https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png)

You can add local image to assets and refer it
![logo](assets/iost-logo-large.png)


### code highlighting

```js
ReactDOM.render(<h1>Hello, world!</h1>, document.getElementById('root'));
```


## Markdown syntax

#### Text
It's very easy to make some words **bold** and other words *italic* with Markdown. You can even [link to Google!](http://google.com)

If you'd like to quote someone, use the > character before the line:

> Coffee. The finest organic suspension ever devised... I beat the Borg with it.
> - Captain Janeway

If you like to Strikethrough
~~this~~

#### Lists

Sometimes you want numbered lists:

1. One
2. Two
3. Three

Sometimes you want bullet points:

* Start a line with a star
* Profit!

Alternatively,

- Dashes work just as well
- And if you have sub points, put two spaces before the dash or star:
  - Like this
  - And this


Horizontal Rule

---


#### Table
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

#### Image

If you want to embed images, this is how you do it:

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)



### Refs

* [Docusaurus markdown](https://docusaurus.io/docs/en/doc-markdown)
* [markdownguide](https://www.markdownguide.org/)
* [Github markdown](https://guides.github.com/features/mastering-markdown/)
