Open Race Timing software
==============

**** WORK IN PROGRESS ***

This will be an universal+modular and open race timing software. Why should be all race timing softwares tightly coupled to one or few sports only? Why should be more ambitious timing solution complex? Why are all working timing softwares closed-source? How can public make sure that timing is calculated properly if it's sources are not public?

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


