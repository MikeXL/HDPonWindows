# R

SparkR, before you start 
    
    install.packages('rJava')
    

## download

  download windows binary from [here][1]

## install

    R CMD INSTALL d:/SparkR_0.1.zip -l c:/users/mike/R

## test drive

    require(SparkR)
    sc <- sparkR.init("local")

  

[1]: http://www.cs.berkeley.edu/~shivaram/sparkr-bin/windows/SparkR_0.1.zip "SparkR binary"
