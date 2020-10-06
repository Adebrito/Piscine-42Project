class doctor (name:string) (age:int) (people:People.people) =
  object (self)

    val _name:string = name
    val _age:int = age
    val _sidekick:People.people = people
    val mutable _hp:int = 100

    initializer begin
      print_endline ("doctor is born " ^ self#to_string);
      print_endline "
      ######      #####      #####  ########  #####    #######            
      ##   ##    ##   ##    ##   ##    ##    ##   ##   ##    ##          
      ##    ##  ##     ##  ##          ##   ##     ##  ##    ##         
      ##    ##  ##     ##  ##          ##   ##     ##  ## ###          
      ##   ##    ##   ##    ##   ##    ##    ##   ##   ##    ##       
############ ########### ########################### ########    ############ 
                                                                       ## 
############     #####     ###########     #####################         ##  
##     #####     #####     ###########     #######################       ##  
##     #####   #######   #####  #####     #####    ###############     ##   
##     #####   #######   #####  #####     #####   #####       #####    ##   
##     ##### ######### #####   #####     #####  #####         #####  ##    
##     ##### ######### #####   ###############  #####         #####  ##    
##     ######### #########    ###############  #####         ##### ##     
##     ######### #########    #####     #####  #####         ##### ##     
 ##     #######   #######     #####     #####   #####       ##### ##      
 ##     #######   #######     #####     #####    ###############  ##      
  ##     #####     #####      #####     #####     #############  ##       
  ##     #####     #####      #####     #####       #########    ##       
   ##                                                           ##        
   ###############################################################"
      end

    method get_hp = _hp
    method to_string = _name ^ " : { hp: " ^ (string_of_int _hp) ^ " age: " ^ (string_of_int _age) ^ " sidekick: " ^ _sidekick#to_string ^ " }"
    method talk = print_endline ("Hi! I'm the Doctor")
    method travel_in_time (start:int) (arrival:int) = 
    print_endline "
              ___
      _______(_@_)_______
      | POLICE      BOX |
      |_________________|
      | _____ | _____ |
      | |###| | |###| |
      | |###| | |###| |   
      | _____ | _____ |   
      | || || | || || |
      | ||_|| | ||_|| |  
      | _____ |$_____ |  
      | || || | || || |  
      | ||_|| | ||_|| | 
      | _____ | _____ |
      | || || | || || |   
      | ||_|| | ||_|| |         
      |       |       |        
      *****************"
    
    method use_sonic_screwdriver = print_endline "Whiiiiwhiiiwhiii Whiiiiwhiiiwhiii Whiiiiwhiiiwhiii"
    method private regenerate = _hp <- 100
    method half_life = _hp <- 50
    method heal = self#regenerate
  end