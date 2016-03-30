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
  
  global{
    long_trip = 9;
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
    fired {
      log ("Raising trip_processed");
      raise explicit event trip_processed attributes event:attrs()
    }
  }
  rule find_long_trips{
    select when explicit trip_processed
    pre{
      mileage = event:attr("mileage").defaultsTo(1);
    }
    if mileage > long_trip then{
      log ("New mileage: " + mileage);
    }
    fired{
      raise explicit event found_long_trip with mileage = ent:long_trip
    }
  }
}
