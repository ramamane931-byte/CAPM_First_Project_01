//definition of the service 
//TCODE: SEGW - Define a service in ABAP
//'@(path: 'MyService')'  this will help to display whole service name without truncate. And we can keep 'path: Spiderman'also.
service MyService @(path: 'MyService'){
    //service end point
    //comment
    function ramdas(name: String) returns String;
}