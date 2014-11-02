Open Race Timing software
==============

**** WORK IN PROGRESS ***

This will be an universal+modular and open race timing software. Why should be all race timing softwares tightly coupled
to one or few sports only? Why should be more ambitious timing solution complex? Why are all working timing softwares
closed-source? How can public make sure that timing is calculated properly if it's sources are not public?

We are trying to answer these questions by modular open-source timing software. Interested? Join us. All kind of experiences welcome!

We plan to do brand new, fresh idea timing software that will be:

* Universal race timing framework for multiple sports, free, open-sourced
* Will have racing events editor, with multiple runs per event
* Flexible racers editor
* Speech processor to express results
* Finish line camera plugins support
* Flexible results display with multiple views over mobile, web etc
* Simple clients for mobile client targeted to end users
* Results filtering on a flexible screen, including results table columns flexible selection
* Plugable calculators for results - covering specific of different sports
* Plugable connectors to different timing devices like Amb mylaps or others
	* device simulator
	* Manual counter using keyboard
	* Other devices plugin
* Results reporting plugin and editor
	* Reporting for printing
	* Support results panel
	* In-place editor of report layout
	* Reporting to cloud web
	* Social network connector
* Plugable import/export data framework
* Simple mobile-like UI 
* Additional useful functions
	* Driver search, full text search
	* Time schedule planning
	* Language editor
	* Driver ranking calculator
* Flexible architecture for client/server setup or client-only setup
* Flexible data store options from simple fiel store upto database or cloud store
* Wide platform support
	* Primary platforms: Windows, Mac OS, Chrome/browser
	* Secondary platforms: Raspberry Pi, Linux, Android, iOS, mobile Windows
* Written in a new modern programming language like Dart [https://www.dartlang.org]

## Module's structure

![Open Race Timing modules](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/ORT_modules.png)

* `Device connector` - has a timing device specific connection code and extracts data timing data. Provides device events as soon as device reports passing, sessions or timelines. Also processes commands to the device from user
* `Calculator` - core component of the system - receives events from device and calculates timing data based on sports specific rules
* `Storage` - stores data with a flexible structure. Provides searching, reporting and caching functionalities
* `Presenter` - express calculator's results to timing operator and end user in flexible,multi-platform way
* `Reporter` - express status result, historical data and trends to printer, cloud, social network etc
* `Shared data editor` - is a racers, events, laps, finals and other data editor
* `Data exchanger` - exports/imports data from/to another system, format etc
* `Event wizard` - drivers user from an event creation, data entry and timing processing

Modules are interconnected by flexible, multi-structure, performing bus way. The bus is in memory native communication among modules based on a standard data structure like JSON.

All modules should be tight together with calculator as it defines data to be calculated for racer and event. Screens and
datastore should be flexible to show and store it. Reporter should has in-place editor to edit reporting layout and connection to
publishing destinations.

Screens are visible artifacts for the user. We have prepared a `very raw` design of screens and screen flow to have a
starting point for discussion. Join us and review screen design to cover requirements you need on for you favorite sport.

![Open Race Timing modules](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/mockups.png)

All screens are based on tables. These should be very flexible to make sure users comfort while presenting data.


## Why Dart?

Why not? Dart seems to be forward thinking open language with great ideas. It also support what we need:
`"...platform for building apps that run on the web or on servers...`. It also runs on almost-embedded devices like
Raspberry Pi. Dart will be also supported on Google cloud soon.

### What is missing in Dart

* dependencies are very hard to maintain. These seems to be working in specific directories like `web`, `bin` etc. Having
more flexible structure with dependencies to external packages is difficult
* reflection i.e. dynamic modules loading is key requirement for modular system. We hope Dart team will extend this soon
see [Dart Mirrors](https://www.dartlang.org/articles/reflection-with-mirrors/)
* Complex full featured IDE. DartEditor is like great start but definitely not full-featured IDE. It does not support
integration with versioning system like Git/Github or others. Idea Dart plugin has full IDE background, but is still bit
incomplete with the language support. The `Chrome Dev Editor` seems to be far from useful - it supports Dart web apps
only.

## Possible installations

We keep in mind the future structure of the installed app. We believe that having flexible app the installation structure
 must be considered from beginning. There are several standard installation structures in the world

* Single PC installation - all on one PC, all starts on one click. Useful for small clubs, hobby installations
* Chrome OS / browser installations - we recognize importance of simple browser based OS like Chrome OS or Firefox. This
  might be interesting for small clubs in the future or for an individuals.
* client - server installations - server and client on separated PC. Server accessible from outside, possibly with mobiles.
Serve is running all the time, clients may be restarted or reconnected if needed. Useful for small races or larger clubs.
* large championship installation - having reliable servers / clustered or in cloud. Multiple secured connection to
timing device. Several time keepers workstations with reliable connection. Very massive connection to server from
 mobile devices or external presenters like scoreboards. Useful for large events.

![Open Race Timing installations](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/client-server.png)


## How it works inside - application architecture

This chapter is outlining ideas we found useful while developing with Dart lang. There are very useful frameworks available
for Dart already.

* Message bus - is used for module-to-module communication flexible way
* Redstone Dart - manages mapping from servers URL to Dart components built as Restone services
* Angulart Dart - works on client side as the MVC pattern
* Polymer Dart - is used for components reusing like tables etc

![Open Race Timing architecture](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/ORTarch.png)





