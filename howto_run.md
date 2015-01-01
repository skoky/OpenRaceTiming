Run ort.dart that starts http server. The server servers html to teh browser on port 8082. Run it like this or similar based on your environment:

    /apps/dart/dart-sdk/bin/dart --ignore-unrecognized-flags --checked --package-root=/work/OpenRaceTiming/packages --enable-vm-service:45622 --trace_service_pause_events /work/OpenRaceTiming/bin/ort.dart

Open chromium browser on url: http://localhost:8082. There is supoprted Chromium only. Support to other browsers is planend as dart can be generated to JavaScript. This is TBD.

