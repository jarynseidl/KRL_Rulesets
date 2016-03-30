ruleset track_trips {
  meta {
    name "track_trips"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    sharing on
    provides hello
 
  }
  rule process_trip{
    select when car new_trip
    pre{
      mileage = event:attr("mileage").defaultsTo("No mileage");
    }
    {
    send_directive("trip") with
      trip_length = mileage;
    }
    always {
      log ("LOG says Hello " + name);
    }
  }
}
