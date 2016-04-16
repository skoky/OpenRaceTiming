Open Race Timing software
==============

**** THIS IS A DESIGN CONCEPT ***

Imagine an universal+modular and open race timing software. Why should be all race timing softwares tightly coupled
to one or few sports only? Why should be more ambitious timing solution complex? Why are all working timing softwares
closed-source? How can public make sure that timing is calculated properly if it's sources are not public?

We are trying to answer these questions by modular open-source timing software. Interested? Join us. All kind of experiences welcome!

For detail list of planned features see this WIki [https://github.com/skoky/OpenRaceTiming/wiki/Detailed-features]

## Logical module

![Open Race Timing Logical Modules structure](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/ORT_modules.png)

* `Device connector` - has a timing device specific connection code and extracts data timing data. Provides device events as soon as device reports passing, sessions or timelines. Also processes commands to the device from user
* `Calculator` - core component of the system - receives events from device and calculates timing data based on sports specific rules
* `Storage` - stores data with a flexible structure. Provides searching, reporting and caching functionalities
* `Presenter` - express calculator's results to timing operator and end user in flexible,multi-platform way
* `Reporter` - express status result, historical data and trends to printer, cloud, social network etc
* `Shared data editor` - is a racers, events, laps, finals and other data editor
* `Data exchanger` - exports/imports data from/to another system, format etc
* `Event wizard` - drivers user from an event creation, data entry and timing processing

Modules are interconnected by flexible, multi-structure, performing bus way. The bus is in memory native communication
among modules based on a standard data structure like JSON.

All modules should be tight together with calculator as it defines data to be calculated for racer and event. Screens and
datastore should be flexible to show and store it. Reporter should has in-place editor to edit reporting layout and connection to
publishing destinations.

## Physical modules

Logical modules are grouped into physical modules to manage complexity. There is a `server module` that contains connection
to device, storage and calculators. This module is accessible over REST/JSON interface. The module `is singleton`, always
works and is connected to device. Always calculates and stores data.
On the other hand there is `client module` that is browser based and is not a singleton. Is started on every clients
browser instance and presents data. Based on logged in user there is visible either only presentation or results or
reporting and management as well.

![Modules structure - physical](https://raw.githubusercontent.com/skoky/OpenRaceTiming/master/doc/ORT%20Module%20physical.png)

If you need more ORT details, see our [Wiki](https://github.com/skoky/OpenRaceTiming/wiki)





