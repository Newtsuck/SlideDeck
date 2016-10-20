Loom Slide Deck!
================

This is a slide deck application written in Loom by Level 4 Development for The Engine Company.

## How to create slides
In order to add slides you must create a new class that inherits from one of the slide types. Acceptable types are:
- `TitleSlide`
- `ListSlide`
- `ImageSlide`

Each of these slide types has an example in the `slides` folder that explain some of the specfic functionality.

Once a slide subclass has been created, it should be added to the `DeckController` in the main `SlideDeck` class. By default the example slides are added to the `DeckController`, so you can just copy that.

## How to run a slideshow
Simply run the project and the slideshow will begin!

In order to move forward in the slideshow, press *any* button on the keyboard except for the left arrow key. Pressing the left arrow key will take you back to the previous slide.

**TIP:** If the slideshow doesn't seem to fit on to the screen properly when first loading, press the left arrow key to reload the first slide. It should resize properly!

## Version Updates
#### 1.0.1
- Major code refactor. No new functionality, just made the project look a bit nicer and be a bit more consistant!
- Added some instructions to the readme and then added this version update. How meta

#### 1.0.0
- API Lock! The existing customization fields will not change for this major version! Note that some fields may be added, but currently available fields will not be changed

#### 0.3.0
- Added support for image slides

#### 0.2.2
- Added support for background images

#### 0.2.1
- Added support for multi line titles on title slides
- Added support for custom title slide "part line"

#### 0.2.0
- Support for transitioning between slides
- Improved support for title slides
- Added *new* list slide
- Added example slides that describe functionality with in-line documentation
- Minor bug fixes

#### 0.1.0
- Basic support for title slides and rendering. This version primarily exists as a basic rendering test to verify functionality on required platforms and is far from feature complete



## Who is Level 4 Development?
Joshua Evans - Engineering - TheJoshuaEvans@gmail.com

Conner Lindsley - Design - ConnerLindsley@gmail.com
