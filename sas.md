

  \* libref;  
  libname hdp hadoop server=unicorn;

  \* passthru;  
  proc sql;
      connect to hadoop (server=unicorn);
  
