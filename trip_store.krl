ruleset trip_store {
  meta {
    name "trip_store"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    sharing on
    provides hello
 
  }
  rule collect_trips{
    select when explicit trip_processed
    pre{
      mileage = event:attr("mileage");
      timestamp = time:now();
      trip = {"mileage":mileage, "time":timestamp};
      all_trips = ent:trips.append(trip);
    }
    always{
      set ent:trips all_trips;
      log("Trip added");
    }
  }
  rule collect_long_trips{
    select when explicit found_long_trip
    pre{
      mileage = event:attr("mileage");
      timestamp = time:now();
      long_trip = {"mileage":mileage, "time":timestamp};
      all_long_trips = ent:long_trips.append(long_trip);
    }
    always{
      set ent:long_trips all_long_trips;
      log("Long trip added");
    }
  }
  rule clear_trips{
    select when car trip_reset
    
    always{
      clear ent:trips;
      clear ent:long_trips;
    }
  }
}





















