
ruleset hello_world {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    sharing on
    provides hello
 
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
  
rule hello_world {
  select when echo hello
  pre{
    name = event:attr("name").defaultsTo(ent:name, "No name passed");
  }
  {
    send_directive("say") with
      something = "Hello #{name}";
  }
  always {
      log ("LOG says Hello " + name);
  }
}

rule message {
  select when echo message
  pre{
    message = event:attr("input").defaultsTo(ent:message, "No message passed");
  }
  {
    send_directive("say") with
      something = message
  }
}

rule store_name {
   select when hello name
   pre{
     passed_name = event:attr("name").klog("our passed in Name: ");
   }
   {
     send_directive("store_name") with
       name = passed_name;
   }
   always{
     set ent:name passed_name;
   }
 }
 
}
